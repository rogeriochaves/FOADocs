class PageController < ApplicationController
  before_filter :authenticate_usuario!, :only => :index

  def index
  end

  def _login
    if u = Usuario.find_by_email(params[:usuario][:email]) and u.valid_password? params[:usuario][:password]
      sign_in u
      render :text => "ok"
    else
      render :text => "error"
    end
  end
  
  def arquivos
    if params[:id]
      @pasta = current_usuario.info_arquivo(params[:id])
    end
    @arquivos = current_usuario.lista_pastas(params[:id])
  end

end
