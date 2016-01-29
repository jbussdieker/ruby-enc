class SaltEvent
  attr_accessor :event

  def initialize(event)
    @event = event
  end

  def minion_id
    event['data']['id']
  end

  def function
    event['data']['fun'].to_s
  end

  def results
    event['data']['return']
  end

  def handle_state_return
    @node = Node.find_or_create_by_name(minion_id)
    @report = Report.create(node_id: @node.id, time: Time.now)

    node_status = "unchanged"

    if results.kind_of?(Hash)
      results.each do |id, status|
	ischanged = false
	skipped = false

	if status['result'] == nil
	  # This is terrible but assume the run is pending if we skip a resource
	  node_status = "pending" if node_status == "unchanged"
	  skipped = true
	  result = true
	elsif status['result'] == true
	  result = true
	elsif status['result'] == false
	  result = false
	  # Should we assume we skip failed resources?
	  skipped = true
	  node_status = "failed"
	end


	if status['changes'].length > 0
	  ischanged = true

	  node_status = "changed" if node_status == "unchanged" && result == true

	  @report.report_logs.create({
	    :time => Time.now,
	    :level => (result ? 'info' : 'err'),
	    :message => status.to_json,
	    :source => id
	  })
	end

	@report.resource_statuses.create({
	  :title => id,
	  :is_changed => ischanged,
	  :skipped => skipped,
	  :failed => (result == false)
	})
      end
    else
      node_status = "failed"

      @report.report_logs.create({
	:time => Time.now,
	:level => 'err',
	:message => { error: results }.to_json,
	:source => ''
      })
    end

    @report.update_attributes(:status => node_status)
    @node.update_attributes(
      status: node_status,
      reported_at: Time.now,
      last_apply_report_id: @report.id
    )
  end

  def handle
    if function.start_with?("state.") && results != nil
      handle_state_return
    end
  end
end

$stdout.sync = true

while true do
  begin
    err = Salt::Api.events do |event|
      SaltEvent.new(event).handle
    end

    puts "Error reading events: #{err}"
    puts err.backtrace.join("\n")
  rescue Interrupt => err
    puts "Gracefully exiting..."
    exit 0
  rescue Exception => err
    puts "Unhandled exception: #{err}"
    puts err.backtrace.join("\n")
  end

  puts "Reconnecting in 10 seconds..."
  sleep 10
end
