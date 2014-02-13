class VersoesController < ApplicationController
	before_filter :authenticate_usuario!
	load_and_authorize_resource
	layout 'administrativo'

	# GET /versoes
	def index
		@versoes = Versao.paginate page: params[:page]
	end

	# GET /versoes/1
	def show
		@versao = Versao.find(params[:id])
	end

	# GET /versoes/new
	def new
		@versao = Versao.new
	end

	# GET /versoes/1/edit
	def edit
		@versao = Versao.find(params[:id])
	end

	# POST /versoes
	def create
		@versao = Versao.new(params[:versao])

		if @versao.save
		  redirect_to(@versao, notice: 'Versao criado com sucesso.')
		  
		else
		  render action: "new"
		end
	end

	# PUT /versoes/1
	def update
		@versao = Versao.find(params[:id])

		if @versao.update(params[:versao])
		  redirect_to(@versao, notice: 'Versao atualizado com sucesso.')
		  
		else
		  render action: "edit"
		end
	end

	# DELETE /versoes/1
	def destroy
		@versao = Versao.find(params[:id])
		@versao.destroy

		redirect_to versoes_url
	end
end