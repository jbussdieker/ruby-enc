class NodeClass < ActiveRecord::Base
  attr_accessible :name

  default_scope order(:name)

  has_many :node_class_memberships, :dependent => :destroy
  has_many :nodes, :through => :node_class_memberships

  validates :name, :uniqueness => true
  validates_presence_of :name

  def to_s
    name
  end
end
