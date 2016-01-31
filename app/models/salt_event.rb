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

  def stamp
    event['data']['_stamp']
  end

  def args
    event['data']['fun_args']
  end

  def test?
    if args && args.find {|arg| arg["test"] == true }
      true
    else
      false
    end
  end

  def results
    event['data']['return']
  end

  def event_statuses
    if results.kind_of?(Hash)
      results.collect { |id, status| SaltEventStatus.new(id, status) }
    else
      []
    end
  end

  def event_status
    event_statuses.collect(&:result)
  end


  def handle_state_return
    @node = Node.find_or_create_by_name(minion_id)
    @report = Report.create(node_id: @node.id, time: Time.now)

    node_status = "unchanged"
    metric_totals = Hash.new(0.0)

    if results.kind_of?(Hash)
      results.each do |id, status|
        ischanged = false
        skipped = false
        resource_type, resource_id, name, action = id.split("_|-", 4)
        category = resource_type + "." + action
        metric_totals[category] += status["duration"]
        @report.metrics.create(
          category: category,
          name: resource_id,
          value: status["duration"]
        )

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

          if test?
            node_status = "pending"
          else
            node_status = "failed"
          end
        end

        if status['changes'].length > 0
          ischanged = true

          node_status = "changed" if node_status == "unchanged" && result == true
        end

        # Only create logs for changes and failures
        if status['changes'].length > 0 || result == false
          @report.report_logs.create({
            :time => Time.now,
            :level => (result ? 'info' : 'err'),
            :message => status.to_json,
            :source => id
          })
        end

        @report.resource_statuses.create({
          :title => "#{category}: #{resource_id}",
          :is_changed => ischanged,
          :skipped => skipped,
          :failed => (result == false)
        })
      end
    else
      # Failed to compile. Treat as pending for test and error for normal runs.
      if test?
        node_status = "pending"
      else
        node_status = "failed"
      end

      @report.report_logs.create({
        :time => Time.now,
        :level => 'err',
        :message => { error: results }.to_json,
        :source => ''
      })
    end

    metric_totals.each do |name, value|
      @report.metrics.create(
        category: name,
        name: "Total",
        value: value
      )
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
