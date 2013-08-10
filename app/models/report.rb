class Report < ActiveRecord::Base
  attr_accessible :node_id, :status
  belongs_to :node

  def filename
    "spool/report-#{id}.yaml"
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

  def parse
    node_name = parsed.name
    node = Node.find_or_create_by_name(node_name)
    self.node_id = node.id
    self.status = parsed.status
    self.environment = parsed.environment
    self.time = parsed.time
    self.save
  end
end
