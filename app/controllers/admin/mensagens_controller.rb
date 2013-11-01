class Admin::MensagensController < ApplicationController
  before_filter :authenticate_usuario!
  load_and_authorize_resource
  layout 'administrativo'

  # GET /mensagens
  def index
    @mensagens = Mensagem.order('created_at DESC').paginate page: params[:page]
  end

  # GET /mensagens/1
  def show
    @mensagem = Mensagem.find(params[:id])
  end
  
end