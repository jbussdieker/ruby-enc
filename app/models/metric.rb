class Metric < ActiveRecord::Base
  attr_accessible :category, :name, :report_id, :value

  belongs_to :report

  validates_presence_of :report_id
end
