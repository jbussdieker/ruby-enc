class Node < ActiveRecord::Base
  attr_accessible :name, :description, :status, :environment, :reported_at, :last_apply_report_id, :parameters_attributes, :node_group_memberships_attributes, :node_class_memberships_attributes

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


  def collapse_parameters
    {}.tap do |params|
      Parameter.where(parameterable_id: nil).each do |parameter|
        params[parameter.key] = parameter.value
      end
      node_groups.each do |node_group|
        node_group.parameters.each do |parameter|
          params[parameter.key] = parameter.value
        end
      end
      parameters.each do |parameter|
        params[parameter.key] = parameter.value
      end
    end
  end

  def to_hash
    {
      "name" => name,
      "environment" => environment,
      "classes" => node_classes.collect(&:name),
      "parameters" => collapse_parameters
    }
  end

  def to_yaml
    to_hash.to_yaml
  end

  def to_param
    name
  end
end
