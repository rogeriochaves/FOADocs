class Arquivo < ActiveRecord::Base
  belongs_to :projeto
  belongs_to :arquivo
end
