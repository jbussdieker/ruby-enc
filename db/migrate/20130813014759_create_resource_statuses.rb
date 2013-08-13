class CreateResourceStatuses < ActiveRecord::Migration
  def change
    create_table :resource_statuses do |t|
      t.integer :report_id
      t.boolean :failed
      t.boolean :skipped
      t.boolean :is_changed
      t.text :title

      t.timestamps
    end

    add_index(:resource_statuses, :report_id)
  end
end
