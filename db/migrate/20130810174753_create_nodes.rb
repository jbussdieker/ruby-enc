class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :status
      t.datetime :last_report

      t.timestamps
    end
  end
end
