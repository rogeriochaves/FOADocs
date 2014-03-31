class Participante < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :projeto
  validates_presence_of :usuario, :grupo
end
