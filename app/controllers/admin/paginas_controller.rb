class Admin::PaginasController < ApplicationController
  before_filter :authenticate_usuario!
  load_and_authorize_resource
  layout 'administrativo'

  # GET /paginas
  def index
    @paginas = Pagina.paginate page: params[:page]
  end

  # GET /paginas/1
  def show
    @pagina = Pagina.find(params[:id])
  end

  # GET /paginas/new
  def new
    @pagina = Pagina.new
  end

  # GET /paginas/1/edit
  def edit
    @pagina = Pagina.find(params[:id])
  end

  # POST /paginas
  def create
    @pagina = Pagina.new(params[:pagina])

    if @pagina.save
      redirect_to([:admin, @pagina], notice: 'Pagina criado com sucesso.')
    else
      render action: "new"
    end
  end

  # PUT /paginas/1
  def update
    @pagina = Pagina.find(params[:id])

    if @pagina.update_attributes(params[:pagina])
      redirect_to([:admin, @pagina], notice: 'Pagina atualizado com sucesso.')
    else
      render action: "edit"
    end
  end

  # DELETE /paginas/1
  def destroy
    @pagina = Pagina.find(params[:id])
    @pagina.destroy

    redirect_to admin_paginas_url
  end
end