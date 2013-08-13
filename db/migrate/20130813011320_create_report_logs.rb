class CreateReportLogs < ActiveRecord::Migration
  def change
    create_table :report_logs do |t|
      t.integer :report_id
      t.string :level
      t.text :message
      t.datetime :time

      t.timestamps
    end

    add_index(:report_logs, :report_id)
  end
end
