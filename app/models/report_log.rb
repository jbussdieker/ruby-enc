class ReportLog < ActiveRecord::Base
  attr_accessible :time, :level, :message, :report_id

  belongs_to :report
end
