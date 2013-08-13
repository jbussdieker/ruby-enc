class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :node_id
      t.string :status
      t.string :environment
      t.datetime :time

      t.timestamps
    end

    add_index(:reports, :node_id)
  end
end
