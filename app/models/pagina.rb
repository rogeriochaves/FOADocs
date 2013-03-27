class Pagina < ActiveRecord::Base
  attr_accessible :description, :title, :url, :metatags
  validates_presence_of :url
end