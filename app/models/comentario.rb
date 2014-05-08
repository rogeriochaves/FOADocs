class Comentario < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :versao
  after_save :gerar_notificacao

  def gerar_notificacao
  	Notificacao.create_with_comentario(self)
  end
end
