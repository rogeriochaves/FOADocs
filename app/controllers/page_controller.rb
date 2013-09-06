class PageController < ApplicationController
  def index
  end

  def contato
    @mensagem = Mensagem.new
    if request.post?
      @mensagem = Mensagem.new(params[:mensagem])
      if @mensagem.save!
        ContatoMailer.enviar_contato(@mensagem).deliver
        @titulo = 'Sua mensagem foi enviada com sucesso'
        @subtitulo = 'Aguarde por uma resposta em sua caixa de entrada de email'
        render action: :ok
      end
    end
  end
  
end
