class NodeClass < ActiveRecord::Base
  attr_accessible :name

  has_many :node_class_memberships
  has_many :nodes, :through => :node_class_memberships
end
