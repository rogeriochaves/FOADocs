class NotificacoesController < ApplicationController
	before_filter :authenticate_usuario!
	load_and_authorize_resource
	layout 'administrativo'

	# GET /notificacoes
	def index
		@notificacoes = Notificacao.paginate page: params[:page]
	end

	# GET /notificacoes/1
	def show
		@notificacao = Notificacao.find(params[:id])
	end

	# GET /notificacoes/new
	def new
		@notificacao = Notificacao.new
	end

	# GET /notificacoes/1/edit
	def edit
		@notificacao = Notificacao.find(params[:id])
	end

	# POST /notificacoes
	def create
		@notificacao = Notificacao.new(params[:notificacao])

		if @notificacao.save
		  redirect_to(@notificacao, notice: 'Notificacao criado com sucesso.')
		  
		else
		  render action: "new"
		end
	end

	# PUT /notificacoes/1
	def update
		@notificacao = Notificacao.find(params[:id])

		if @notificacao.update(params[:notificacao])
		  redirect_to(@notificacao, notice: 'Notificacao atualizado com sucesso.')
		  
		else
		  render action: "edit"
		end
	end

	# DELETE /notificacoes/1
	def destroy
		@notificacao = Notificacao.find(params[:id])
		@notificacao.destroy

		redirect_to notificacoes_url
	end
end