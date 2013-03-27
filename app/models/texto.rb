class Texto < ActiveRecord::Base
  belongs_to :pagina
  attr_accessible :texto, :pagina_id
end
