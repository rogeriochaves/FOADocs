class Pagina < ActiveRecord::Base
  validates_presence_of :url
end