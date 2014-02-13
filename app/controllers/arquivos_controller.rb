class ArquivosController < ApplicationController
	before_filter :authenticate_usuario!
	load_and_authorize_resource
	layout 'administrativo'

	# GET /arquivos
	def index
		@arquivos = Arquivo.paginate page: params[:page]
	end

	# GET /arquivos/1
	def show
		@arquivo = Arquivo.find(params[:id])
	end

	# GET /arquivos/new
	def new
		@arquivo = Arquivo.new
	end

	# GET /arquivos/1/edit
	def edit
		@arquivo = Arquivo.find(params[:id])
	end

	# POST /arquivos
	def create
		@arquivo = Arquivo.new(params[:arquivo])

		if @arquivo.save
		  redirect_to(@arquivo, notice: 'Arquivo criado com sucesso.')
		  
		else
		  render action: "new"
		end
	end

	# PUT /arquivos/1
	def update
		@arquivo = Arquivo.find(params[:id])

		if @arquivo.update(params[:arquivo])
		  redirect_to(@arquivo, notice: 'Arquivo atualizado com sucesso.')
		  
		else
		  render action: "edit"
		end
	end

	# DELETE /arquivos/1
	def destroy
		@arquivo = Arquivo.find(params[:id])
		@arquivo.destroy

		redirect_to arquivos_url
	end
end