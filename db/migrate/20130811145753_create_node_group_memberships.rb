class CreateNodeGroupMemberships < ActiveRecord::Migration
  def change
    create_table :node_group_memberships do |t|
      t.integer :node_id
      t.integer :node_group_id

      t.timestamps
    end
  end
end
