class Node < ActiveRecord::Base
  attr_accessible :name, :status, :last_report
  has_many :reports, :order => 'time DESC'

  def to_param
    name
  end
end
