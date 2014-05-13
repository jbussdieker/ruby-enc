class Report < ActiveRecord::Base
  belongs_to :node

  has_many :report_logs, :dependent => :delete_all
  has_many :metrics, :dependent => :delete_all
  has_many :resource_statuses, :dependent => :delete_all
end
