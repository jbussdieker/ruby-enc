class AddSourceToReportLogs < ActiveRecord::Migration
  def change
    add_column :report_logs, :source, :string
  end
end
