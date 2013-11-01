# encoding: UTF-8
class Admin::UsuariosController < ApplicationController
  before_filter :authenticate_usuario!
  load_and_authorize_resource
  layout 'administrativo'

  # GET /usuarios
  def index
    @usuarios = Usuario.paginate :page => params[:page]
  end

  # GET /usuarios/1
  def show
    @usuario = Usuario.find(params[:id])
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
  end

  # POST /usuarios
  def create
    @usuario = Usuario.new(params[:usuario])

    if @usuario.save
      redirect_to [:admin, @usuario], :notice => 'Usuario cadastrado com sucesso.'
    else
      render :action => "new"
    end
  end

  # PUT /usuarios/1
  def update
    @usuario = Usuario.find(params[:id])

    if @usuario.admin? and params[:usuario][:grupo] != 'admin' and Usuario.where(:grupo => 'admin').count == 1
  		flash[:notice] = "O sistema deve possuir pelo menos um administrador"
  		render :action => "edit"
  	else
	    if @usuario.update(params[:usuario])
	      redirect_to [:admin, @usuario], :notice => 'Usuario atualizado com sucesso.'
	    else
	      render :action => "edit"
	    end
	  end
  end

  # DELETE /usuarios/1
  def destroy
    @usuario = Usuario.find(params[:id])
  	if Usuario.where(:grupo => 'admin').count == 1 and @usuario.admin?
  		flash[:notice] = "Você não pode deletar o único administrador do sistema"
  	else
	    @usuario.destroy
	  end

    redirect_to admin_usuarios_url
  end

  def change_password
  	if params[:usuario]
  		u = current_usuario

      @erro = "A senha deve ser diferente da sua senha atual" if u.valid_password? params[:usuario][:password]
  		@erro = "A senha deve possuir mais de 3 caracteres" if params[:usuario][:password].size <= 3

  		if !@erro and u.update_attributes(params[:usuario])
  			u.update_attribute(:change_password, false)
  			sign_in u
	      redirect_to :controller => '/admin/admin', :action => :index, :notice => 'Usuario atualizado com sucesso.'
  		end
  	end
  end

end