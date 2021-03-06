class CreateNodeGroups < ActiveRecord::Migration
  def change
    create_table :node_groups do |t|
      t.string :name, :null => false

      t.timestamps
    end

    add_index(:node_groups, :name, :unique => true)
  end
end
