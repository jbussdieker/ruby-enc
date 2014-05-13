class Parameter < ActiveRecord::Base
  belongs_to :parameterable, polymorphic: true

  validates_uniqueness_of :key, :scope => [:parameterable_id, :parameterable_type]

  validates_presence_of :key
  validates_presence_of :value
end
