def event_handler(event)
  node_name ||= event['data']['id']

  puts event.to_yaml
  if event['data']['fun'] == "state.highstate" && event['data']['return'] != nil
    puts "HIGHSTATE"

    @node = Node.find_or_create_by_name(node_name)
    @report = Report.create(node_id: @node.id, time: Time.now)

    node_status = "unchanged"

    if event['data']['return'].kind_of?(Hash)
      event['data']['return'].each do |id, status|
        ischanged = false
        skipped = false

        if status['changes'].length > 0
          ischanged = true
          changed = true
          changes = ""

          if status['changes'].kind_of?(Hash)
            changes = (status.reject {|k,v| k == 'diff'}).to_yaml
            changes += status['changes']['diff'] || ""
          else
            changes = status['changes']
          end

          if status['result'] == nil
            node_status = "pending" # This is terrible but assume the run is pending if we skip a resource
            skipped = true
            result = true
          elsif status['result'] == true
            node_status = "changed"
            result = true
            node_status = "changed"
          else
            result = false
            skipped = true # Should we assume we skip failed resources?
            node_status = "failed"
          end

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
        :message => event['data']['return'],
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
end

$stdout.sync = true

while true do
  begin
    err = Salt::Api.events do |event|
      event_handler(event)
    end

    puts "Error reading events: #{err}"
    puts err.backtrace.join("\n")
  rescue Exception => err
    puts "Unhandled exception: #{err}"
    puts err.backtrace.join("\n")
  end

  puts "Reconnecting in 10 seconds..."
  sleep 10
end
