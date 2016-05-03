class AddIndexToNodeGroupMemberships < ActiveRecord::Migration
  def change
  	 add_index :node_group_memberships, :node_group_id
  end
end
