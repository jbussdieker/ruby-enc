class Report < ActiveRecord::Base
  attr_accessible :node_id, :status
  belongs_to :node
  has_many :report_logs, :dependent => :destroy
  has_many :metrics, :dependent => :destroy
  has_many :resource_statuses, :dependent => :destroy

  default_scope order("time DESC")

  after_destroy :delete_file

  def delete_file
    if File.exists? filename
      File.delete(filename)
    end
  end

  def spool_path
    File.expand_path("../../../spool", __FILE__)
  end

  def filename
    File.join(spool_path, "report-#{id}.yaml")
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
    parsed.logs.each do |log|
      report_logs.create(
        :time => log.time,
        :level => log.level,
        :message => log.message
      )
    end
  end

  def parse_metrics
    parsed.metrics.each do |name,metric|
      metric.values.each do |key,description,value|
        metrics.create(
          :category => metric.label,
          :name => description,
          :value => value
        )
      end
    end
  end

  def parse_resource_statuses
    parsed.resource_statuses.each do |name,status|
      if status.changed or status.failed
        resource_statuses.create(
          :title => name,
          :is_changed => status.changed,
          :skipped => status.skipped,
          :failed => status.failed
        )
      end
    end
  end

  def relay
    if relay_settings = ENC_CONFIG[:report_relay]
      client = Net::HTTP.new(relay_settings[:host], relay_settings[:port])
      req = Net::HTTP::Post.new("/reports/upload")
      req["Content-Type"] = "application/x-yaml"
      req.body = raw_report
      resp = client.request(req)
    end
  end

  def parse_status
    s = parsed.status
    parsed.resource_statuses.each do |name,status|
      if !status.changed and status.out_of_sync
        s = "pending"
      end
    end
    s
  end

  def parse
    relay

    parse_logs
    parse_metrics
    parse_resource_statuses

    node_name = parsed.name
    node = Node.find_or_create_by_name(node_name)
    self.node_id = node.id
    self.status = parse_status
    self.environment = parsed.environment
    self.time = parsed.time
    self.save
    node.update_attributes(:status => parse_status, :reported_at => parsed.time)

    delete_file
  end
end
