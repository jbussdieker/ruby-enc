class Parameter < ActiveRecord::Base
  attr_accessible :key, :parameterable_id, :parameterable_type, :value
end
