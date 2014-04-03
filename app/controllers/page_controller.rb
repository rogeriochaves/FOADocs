class PageController < ApplicationController
  before_filter :authenticate_usuario!, :except => :_login
  before_filter :set_projeto, :except => [:novo_projeto, :_login]

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
        redirect_to action: :index, projeto_id: @projeto.id
      end
    end
  end

  def _comentar
    if params[:comentario] and @versao = Versao.find(params[:comentario][:versao_id]) and @versao.arquivo and @versao.arquivo.projeto_id and current_usuario.projeto_ids.include?(@versao.arquivo.projeto_id)
      @comentario = Comentario.new(params[:comentario])
      @comentario.usuario = current_usuario
      if @comentario.save
        render :text => "ok"
      else
        render :text => "error"
      end
    else
      render :text => "error"
    end
  end

end
