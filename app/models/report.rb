class Report < ActiveRecord::Base
  attr_accessible :node_id, :status
  belongs_to :node
  has_many :report_logs, :dependent => :destroy
  has_many :metrics, :dependent => :destroy

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

  def parse
    parse_logs
    parse_metrics

    node_name = parsed.name
    node = Node.find_or_create_by_name(node_name)
    self.node_id = node.id
    self.status = parsed.status
    self.environment = parsed.environment
    self.time = parsed.time
    self.save
    node.update_attributes(:status => parsed.status, :reported_at => parsed.time)
  end
end
