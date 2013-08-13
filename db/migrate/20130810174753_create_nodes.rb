class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name, :null => false
      t.text :description
      t.datetime :reported_at
      t.integer :last_apply_report_id
      t.string :status
      t.boolean :hidden, :default => false
      t.integer :last_inspect_report_id

      t.timestamps
    end

    add_index(:nodes, :name, :unique => true)
  end
end
