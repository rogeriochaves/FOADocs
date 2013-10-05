class ApplicationController < ActionController::Base
  helper_method :masc_fem
  before_filter :beta_authentication, :tabs_configure, :change_password_redirect
  #protect_from_forgery

  def change_password_redirect
  	if !session[:react_login] and current_usuario and current_usuario.change_password and
  	   !(params[:controller] == 'admin/usuarios' and params[:action] == 'change_password') and
  	   !(params[:controller] == 'sessions' and params[:action] == 'destroy')

  		redirect_to :controller => '/admin/usuarios', :action => 'change_password'
  	end
  end

  def beta_authentication
    if request.host.include? "herokuapp" or request.host.include? "reactweb"
      authenticate_or_request_with_http_basic do |username, password|
        username == "react" && password == "rct364"
      end
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
