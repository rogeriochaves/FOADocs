class Participante < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :projeto
end
