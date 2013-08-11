class NodeGroupMembership < ActiveRecord::Base
  attr_accessible :node_group_id, :node_id
  attr_accessible :node_group

  belongs_to :node
  belongs_to :node_group
end
