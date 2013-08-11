class CreateNodeClasses < ActiveRecord::Migration
  def change
    create_table :node_classes do |t|
      t.string :name

      t.timestamps
    end
  end
end
