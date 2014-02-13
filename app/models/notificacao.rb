class Notificacao < ActiveRecord::Base
  belongs_to :arquivo
  belongs_to :versao
  belongs_to :comentario
  belongs_to :usuario
end
