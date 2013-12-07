class Parameter < ActiveRecord::Base
  attr_accessible :key, :parameterable_id, :parameterable_type, :value

  validates_presence_of :key
  validates_presence_of :value
end
