class ReportLog < ActiveRecord::Base
  attr_accessible :time, :level, :message, :source, :report_id

  belongs_to :report

  def message
    JSON.parse(super)
  end
end
