class Editavel < ActiveRecord::Base
  validates_uniqueness_of :chave
  attr_accessor :size
  has_attached_file :foto, :styles => lambda { |editavel| { :small => editavel.instance.size } }
end