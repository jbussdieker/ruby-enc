class Node < ActiveRecord::Base
  attr_accessible :name
  has_many :reports

  def to_param
    name
  end

  def last_report
    report = reports.last
    if report
      report.time
    else
      "not reported"
    end
  end
end
