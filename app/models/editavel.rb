class Editavel < ActiveRecord::Base
  attr_accessible :chave, :foto, :texto, :size
  validates_uniqueness_of :chave
  attr_accessor :size
  has_attached_file :foto, :styles => lambda { |editavel| { :small => editavel.instance.size } }
end