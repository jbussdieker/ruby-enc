class Node < ActiveRecord::Base
  include PuppetDB::Node

  attr_accessible :name, :description, :status, :reported_at
  attr_accessible :parameters_attributes
  attr_accessible :node_group_memberships_attributes
  attr_accessible :node_class_memberships_attributes

  has_many :reports, :dependent => :destroy

  has_many :node_group_memberships, :dependent => :destroy
  has_many :node_groups, :through => :node_group_memberships

  has_many :node_class_memberships, :dependent => :destroy
  has_many :node_classes, :through => :node_class_memberships

  has_many :parameters, :as => :parameterable, :dependent => :destroy

  accepts_nested_attributes_for :parameters, :allow_destroy => true, :reject_if => lambda {|p| p[:key].empty? || p[:value].empty?}
  accepts_nested_attributes_for :node_class_memberships, :allow_destroy => true, :reject_if => lambda {|p| p[:node_class_id].empty?}
  accepts_nested_attributes_for :node_group_memberships, :allow_destroy => true, :reject_if => lambda {|p| p[:node_group_id].empty?}

  scope :responsive, -> { where("reported_at >= '#{Time.now.utc - 3600}'") }
  scope :unresponsive, -> { where("reported_at < '#{Time.now.utc - 3600}'") }
  scope :changed, -> { responsive.where(:status => "changed") }
  scope :unchanged, -> { responsive.where(:status => "unchanged") }
  scope :failed, -> { responsive.where(:status => "failed") }
  scope :pending, -> { responsive.where(:status => "pending") }
  scope :unreported, -> { where(:status => nil) }

  validates :name, :uniqueness => true
  validates_presence_of :name

  def to_s
    name
  end

  def to_param
    name
  end
end
