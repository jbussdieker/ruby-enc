class NodeGroup < ActiveRecord::Base
  attr_accessible :name

  default_scope order(:name)

  has_many :node_group_memberships, :dependent => :destroy
  has_many :nodes, :through => :node_group_memberships
  has_many :parameters, :as => :parameterable, :dependent => :destroy

  accepts_nested_attributes_for :parameters
  attr_accessible :parameters_attributes

  before_save :mark_children_for_removal

  validates :name, :uniqueness => true

  def to_s
    name
  end

  def mark_children_for_removal
    parameters.each do |parameter|
      parameter.mark_for_destruction if parameter.key.blank?
    end
  end
end
