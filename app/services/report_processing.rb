class ReportProcessing
  def initialize(report)
    @report = report
  end

  def spool_path
    ENC_CONFIG[:spool_path] || File.expand_path("../../../spool", __FILE__)
  end

  def filename
    File.join(spool_path, "report-#{@report.id}.yaml")
  end

  def delete_file
    if File.exists? filename
      File.delete(filename)
    end
  end

  def write(data)
    File.open(filename, 'w') {|f| f.write(data)}
  end

  def raw_report
    @raw_report ||= File.read(filename)
  end

  def parsed
    @parsed ||= YAML.load(raw_report)
  end

  def parse_logs
    parsed.logs.collect do |log|
      {
        :time => log.time,
        :level => log.level,
        :message => log.message,
        :source => log.source
      }
    end
  end

  def parse_metrics
    parsed.metrics.collect do |name, metric|
      metric.values.collect do |key, description, value|
        {
          :category => metric.label,
          :name => description,
          :value => value
        }
      end
    end.flatten
  end

  def parse_resource_statuses
    parsed.resource_statuses.collect do |name, status|
      if status and (status.changed or status.failed)
        {
          :title => name,
          :is_changed => status.changed,
          :skipped => status.skipped,
          :failed => status.failed
        }
      end
    end.compact
  end

  def parse_status
    s = parsed.status
    if s != "failed"
      parsed.resource_statuses.each do |name, status|
        if status and !status.changed and status.out_of_sync
          s = "pending"
        end
      end
    end
    s
  end

  def parse
    node_name = parsed.name

    @report.node = Node.find_or_create_by(name: node_name)
    @report.report_logs.create(parse_logs)
    @report.metrics.create(parse_metrics)
    @report.resource_statuses.create(parse_resource_statuses)

    @report.update_attributes(
      :node_id     => @report.node.id,
      :status      => parse_status,
      :environment => parsed.environment,
      :time        => parsed.time
    )

    @report.node.update_attributes(
      :status               => parse_status,
      :reported_at          => parsed.time,
      :last_apply_report_id => @report.id
    )

    delete_file
  end
end
