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

    if @usuario.update_attributes(params[:usuario])
      redirect_to [:admin, @usuario], :notice => 'Usuario atualizado com sucesso.'
    else
      render :action => "edit"
    end
  end

  # DELETE /usuarios/1
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    redirect_to admin_usuarios_url
  end

end