class ComentariosController < ApplicationController
	before_filter :authenticate_usuario!
	load_and_authorize_resource
	layout 'administrativo'

	# GET /comentarios
	def index
		@comentarios = Comentario.paginate page: params[:page]
	end

	# GET /comentarios/1
	def show
		@comentario = Comentario.find(params[:id])
	end

	# GET /comentarios/new
	def new
		@comentario = Comentario.new
	end

	# GET /comentarios/1/edit
	def edit
		@comentario = Comentario.find(params[:id])
	end

	# POST /comentarios
	def create
		@comentario = Comentario.new(params[:comentario])

		if @comentario.save
		  redirect_to(@comentario, notice: 'Comentario criado com sucesso.')
		  
		else
		  render action: "new"
		end
	end

	# PUT /comentarios/1
	def update
		@comentario = Comentario.find(params[:id])

		if @comentario.update(params[:comentario])
		  redirect_to(@comentario, notice: 'Comentario atualizado com sucesso.')
		  
		else
		  render action: "edit"
		end
	end

	# DELETE /comentarios/1
	def destroy
		@comentario = Comentario.find(params[:id])
		@comentario.destroy

		redirect_to comentarios_url
	end
end