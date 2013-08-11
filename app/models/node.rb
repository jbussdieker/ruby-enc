class Node < ActiveRecord::Base
  attr_accessible :name, :status, :last_report

  has_many :reports, :order => 'time DESC', :dependent => :destroy

  has_many :node_group_memberships, :dependent => :destroy
  has_many :node_groups, :through => :node_group_memberships

  has_many :node_class_memberships, :dependent => :destroy
  has_many :node_classes, :through => :node_class_memberships

  has_many :parameters, :as => :parameterable, :dependent => :destroy

  accepts_nested_attributes_for :parameters
  attr_accessible :parameters_attributes

  before_save :mark_children_for_removal

  def mark_children_for_removal
    parameters.each do |parameter|
      parameter.mark_for_destruction if parameter.key.blank?
    end
  end

  def to_param
    name
  end
end
