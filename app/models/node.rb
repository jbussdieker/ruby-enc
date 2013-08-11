class Node < ActiveRecord::Base
  attr_accessible :name, :status, :last_report
  has_many :reports, :order => 'time DESC', :dependent => :destroy
  has_many :node_group_memberships
  has_many :node_groups, :through => :node_group_memberships

  def to_param
    name
  end
end
