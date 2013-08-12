class CreateNodeClasses < ActiveRecord::Migration
  def change
    create_table :node_classes do |t|
      t.string :name, :null => false

      t.timestamps
    end

    add_index(:node_classes, :name, :unique => true)
  end
end
