class NodeClassMembership < ActiveRecord::Base
  attr_accessible :node_class_id, :node_id
  attr_accessible :node_class, :node

  belongs_to :node
  belongs_to :node_class
end
