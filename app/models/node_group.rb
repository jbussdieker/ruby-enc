class NodeGroup < ActiveRecord::Base
  has_many :node_group_memberships, :dependent => :destroy
  has_many :nodes, :through => :node_group_memberships
  has_many :parameters, :as => :parameterable, :dependent => :destroy

  accepts_nested_attributes_for :parameters, :allow_destroy => true

  validates :name, :uniqueness => true
  validates_presence_of :name

  def serializable_hash(options={})
    options = { 
      :include => {
        :parameters => {}
      }
    }.update(options)
    super(options)
  end

  def to_s
    name
  end

  def to_param
    name
  end
end
