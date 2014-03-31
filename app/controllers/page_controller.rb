class PageController < ApplicationController
  before_filter :authenticate_usuario!, :except => :_login
  before_filter :set_projeto, :except => :novo_projeto

  def set_projeto
    redirect_to action: :novo_projeto if !current_projeto
  end

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
    if params[:folder_id]
      @pasta = current_usuario.info_arquivo(params[:folder_id])
      folder_id = params[:folder_id]
    else
      root_folder = current_projeto.find_root_folder(current_usuario)
      folder_id = root_folder.id
      @pasta = current_usuario.info_arquivo(folder_id)
    end
    @arquivos = current_usuario.lista_arquivos(folder_id)
  end

  def novo_projeto
    @projeto = Projeto.new
    if params[:projeto]
      @projeto = Projeto.new(params[:projeto])
      @projeto.participantes.build(usuario: current_usuario, grupo: "admin")
      if @projeto.save
        session[:current_projeto] = @projeto.id
        redirect_to action: :index
      end
    end
  end

end
