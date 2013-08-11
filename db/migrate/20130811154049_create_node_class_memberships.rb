class CreateNodeClassMemberships < ActiveRecord::Migration
  def change
    create_table :node_class_memberships do |t|
      t.integer :node_id
      t.integer :node_class_id

      t.timestamps
    end
  end
end
