class IncreaseMessageLength < ActiveRecord::Migration
  def change
    change_column :report_logs, :message, :text, :limit => nil
  end
end
