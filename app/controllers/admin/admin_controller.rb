# encoding: UTF-8
class Admin::AdminController < ApplicationController

  before_filter :authenticate_usuario!
  layout 'administrativo'

  def index
  	session[:attempts] = 0
  	if !can? :index, :admin
      flash[:alert] = "Permissão Negada"
      sign_out(:usuario)
      redirect_to new_session_path(:usuario)
    end
  end

end
