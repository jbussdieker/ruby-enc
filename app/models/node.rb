class Node < ActiveRecord::Base
  attr_accessible :name, :status, :last_report
  has_many :reports, :order => 'time DESC', :dependent => :destroy

  def to_param
    name
  end
end
