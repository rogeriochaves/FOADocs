class Notificacao < ActiveRecord::Base
  belongs_to :arquivo
  belongs_to :versao
  belongs_to :comentario
  belongs_to :usuario

  def self.create_with_comentario(comentario)
  	if projeto = comentario.versao.arquivo.projeto
      projeto.usuarios.each do |usuario|
        Notificacao.create(usuario: usuario, comentario: comentario, texto: "<b>#{comentario.usuario.nome}</b> comentou no arquivo <b>#{comentario.versao.arquivo.nome}</b>", lido: false)
      end
    end
  end
end
