class Metric < ActiveRecord::Base
  belongs_to :report

  validates_presence_of :report_id
end
