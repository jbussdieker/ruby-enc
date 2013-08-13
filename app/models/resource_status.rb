class ResourceStatus < ActiveRecord::Base
  attr_accessible :is_changed, :failed, :report_id, :skipped, :title

  belongs_to :report
end
