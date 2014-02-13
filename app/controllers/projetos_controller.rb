class ProjetosController < ApplicationController
	before_filter :authenticate_usuario!
	load_and_authorize_resource
	layout 'administrativo'

	# GET /projetos
	def index
		@projetos = Projeto.paginate page: params[:page]
	end

	# GET /projetos/1
	def show
		@projeto = Projeto.find(params[:id])
	end

	# GET /projetos/new
	def new
		@projeto = Projeto.new
	end

	# GET /projetos/1/edit
	def edit
		@projeto = Projeto.find(params[:id])
	end

	# POST /projetos
	def create
		@projeto = Projeto.new(params[:projeto])

		if @projeto.save
		  redirect_to(@projeto, notice: 'Projeto criado com sucesso.')
		  
		else
		  render action: "new"
		end
	end

	# PUT /projetos/1
	def update
		@projeto = Projeto.find(params[:id])

		if @projeto.update(params[:projeto])
		  redirect_to(@projeto, notice: 'Projeto atualizado com sucesso.')
		  
		else
		  render action: "edit"
		end
	end

	# DELETE /projetos/1
	def destroy
		@projeto = Projeto.find(params[:id])
		@projeto.destroy

		redirect_to projetos_url
	end
end