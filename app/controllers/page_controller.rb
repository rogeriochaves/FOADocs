class PageController < ApplicationController
  before_filter :authenticate_usuario!, :except => :_login
  before_filter :set_projeto, :except => [:novo_projeto, :_login, :aceitar_convite]

  def set_projeto
    redirect_to action: :novo_projeto if !current_projeto
  end

  def index
    if participante = Participante.where(usuario_id: current_usuario.id, projeto_id: current_projeto.id).first
      if participante.grupo == "admin"
        current_projeto.update_changes(current_usuario)
      elsif root = current_projeto.find_root_folder(current_usuario)
        current_projeto.update_changes(current_usuario, root)
      else
        @aceitar_convite_gdrive = true
      end
    end
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

  def convidar
    @usuario = Usuario.new
    if params[:usuario] and params[:usuario][:email]
      ContatoMailer.enviar_convite(current_usuario, current_projeto, params[:usuario][:email]).deliver
      flash[:notice] = "Convite enviado para #{params[:usuario][:email]} com sucesso"
      redirect_to :action => :index
    end
  end

  def aceitar_convite
    if params[:projeto_id] and params[:email] and params[:key]
      email = params[:email]
      if projeto = Projeto.find(params[:projeto_id])
        if projeto.md5_key(email) == params[:key]
          #if current_usuario.email == email
            if participante = Participante.where(usuario_id: current_usuario.id, projeto_id: projeto.id).first
              flash[:error] = "Você já está participando deste projeto"
            else
              Participante.create(usuario_id: current_usuario.id, projeto_id: projeto.id, grupo: "membro")
              projeto.share_folder(email)
              flash[:notice] = "Você agora está participando do projeto #{projeto.nome}, agora veja seu email e aceite o convite no Google Drive para participar da pasta compartilhada"
              redirect_to controller: :page, action: :index, projeto_id: projeto.id and return
            end
          #else
          #  flash[:error] = "Você só pode aceitar este convite com uma conta atrelada ao email #{email} no Google Drive"
          #end
        else
          flash[:error] = "ID do projeto ou email incorreto"
        end
      else
        flash[:error] = "Projeto não encontrado"
      end
    end
    redirect_to action: :index
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
