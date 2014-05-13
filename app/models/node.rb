class Node < ActiveRecord::Base
  include PuppetDB::Node

  has_many :reports, :dependent => :destroy

  has_many :node_group_memberships, :dependent => :destroy
  has_many :node_groups, :through => :node_group_memberships

  has_many :node_class_memberships, :dependent => :destroy
  has_many :node_classes, :through => :node_class_memberships

  has_many :parameters, :as => :parameterable, :dependent => :destroy

  accepts_nested_attributes_for :parameters, :allow_destroy => true
  accepts_nested_attributes_for :node_class_memberships, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :node_group_memberships, :allow_destroy => true, :reject_if => :all_blank

  scope :responsive, -> { where("reported_at >= '#{Time.now.utc - 3600}'") }
  scope :unresponsive, -> { where("reported_at < '#{Time.now.utc - 3600}'") }
  scope :changed, -> { responsive.where(:status => "changed") }
  scope :unchanged, -> { responsive.where(:status => "unchanged") }
  scope :failed, -> { responsive.where(:status => "failed") }
  scope :pending, -> { responsive.where(:status => "pending") }
  scope :unreported, -> { where(:status => nil) }

  validates :name, :uniqueness => true
  validates_presence_of :name

  def serializable_hash(options={})
    options = { 
      :include => {
        :parameters => {},
        :node_groups => {},
        :node_classes => {}
      }
    }.update(options)
    super(options)
  end

  def to_s
    name
  end

  def environment
    super.to_s.empty? ? "production" : super
  end

  def to_yaml
    all_classes = node_classes.collect {|node_class| node_class.name}
    all_parameters = {}
    node_groups.each do |node_group|
      node_group.parameters.each do |parameter|
        all_parameters[parameter.key] = parameter.value
      end
    end
    parameters.each do |parameter|
      all_parameters[parameter.key] = parameter.value
    end

    {
      "classes" => all_classes,
      "name" => name,
      "environment" => environment,
      "parameters" => all_parameters
    }.to_yaml
  end

  def to_param
    name
  end
end
