class ApplicationController < ActionController::Base
  helper_method :masc_fem, :current_projeto
  before_filter :tabs_configure, :login_with_google#, :change_password_redirect
  #protect_from_forgery

  def login_with_google
    if current_usuario and !current_usuario.token and !current_usuario.admin?
      redirect_to usuario_omniauth_authorize_path(:google_oauth2)
    end
  end

  def change_password_redirect
  	if !session[:react_login] and current_usuario and current_usuario.change_password and
  	   !(params[:controller] == 'admin/usuarios' and params[:action] == 'change_password') and
  	   !(params[:controller] == 'sessions' and params[:action] == 'destroy')

  		redirect_to :controller => '/admin/usuarios', :action => 'change_password'
  	end
  end

  def tabs_configure
    load Rails.root + 'config/initializers/app_admin.rb' if Rails.env == "development"
  end

  def not_found
    return render :file => "public/404.html", :status => 404, :layout => false
  end

  def current_ability
	  @current_ability ||= Ability.new(current_usuario)
  end

  def current_projeto
    if !current_usuario
      return nil
    end
    if @current_projeto
      return @current_projeto
    elsif params[:projeto_id]
      @current_projeto = current_usuario.projetos.where(id: params[:projeto_id]).first
    elsif session[:current_projeto]
      @current_projeto = current_usuario.projetos.where(id: session[:current_projeto]).first
    end
    if !@current_projeto
      @current_projeto = current_usuario.projetos.first
    end
    session[:current_projeto] = @current_projeto.id if @current_projeto
    return @current_projeto
  end

  def masc_fem(string, masc, fem)
    string = string.downcase.singularize
    irr = {
      cidade: fem,
      mensagem: fem,
      secao: fem,
      foto: fem
    }
    irr[string.to_sym] ? irr[string.to_sym] : string =~ /(a)$/i ? fem : masc
  end

  rescue_from CanCan::AccessDenied do |exception|
  	flash[:notice] = "Acesso negado"
    redirect_to(current_usuario ? {:controller => '/admin/admin'} : new_usuario_session_path)
  end
end
