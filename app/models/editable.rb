class Editable < ActiveRecord::Base
  validates_uniqueness_of :key
  attr_accessor :size
  has_attached_file :picture, :styles => lambda { |editable| { :small => editable.instance.size } }
end