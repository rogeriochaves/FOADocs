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

  def self.create_with_versao(versao)
    if projeto = versao.arquivo.projeto

      if versao.mudanca == "renomeado"
        texto = "#{versao.versao_anterior.nome} <b>#{versao.mudanca} para</b> #{versao.nome}"
      elsif versao.mudanca == "renomeada"
        texto = "Pasta #{versao.versao_anterior.nome} <b>#{versao.mudanca} para</b> #{versao.nome}"
      else
        texto = "#{versao.arquivo.diretorio ? "Pasta" : ""} #{versao.nome} <b>#{versao.mudanca}</b>"
      end

      projeto.usuarios.each do |usuario|
        Notificacao.create(usuario: usuario, versao: versao, texto: texto, lido: false)
      end
    end
  end

end