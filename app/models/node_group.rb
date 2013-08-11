class NodeGroup < ActiveRecord::Base
  attr_accessible :name

  has_many :node_group_memberships, :dependent => :destroy
  has_many :nodes, :through => :node_group_memberships
  has_many :parameters, :as => :parameterable, :dependent => :destroy
end
