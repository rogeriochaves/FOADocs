# encoding: UTF-8
class ContatoMailer < ActionMailer::Base
  default :from => "#{AppAdmin.app_name} <contato@#{AppAdmin.domain}>"

  def enviar_contato(mensagem)
    @mensagem = mensagem
    mail(
      to: (Rails.env == "production" ? "#{AppAdmin.app_name} <contato@#{AppAdmin.domain}>" : "<rogerio@reactweb.com.br>"),
      subject: "Mensagem de Contato do #{AppAdmin.app_name}",
      reply_to: @mensagem.email
    ) do |format|
      format.html { render 'enviar_contato' }
    end
  end
  
end