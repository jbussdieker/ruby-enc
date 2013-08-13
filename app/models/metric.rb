class Metric < ActiveRecord::Base
  attr_accessible :category, :name, :report_id, :value

  belongs_to :report
end
