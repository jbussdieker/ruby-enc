class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.integer :report_id, :null => false
      t.string :category
      t.string :name
      t.decimal :value, :precision => 12, :scale => 6

      t.timestamps
    end

    add_index(:metrics, :report_id)
  end
end
