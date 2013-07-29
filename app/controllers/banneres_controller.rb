class BanneresController < ApplicationController
  before_filter :authenticate_usuario!
  load_and_authorize_resource
  layout 'administrativo'

  # GET /banneres
  def index
    @banneres = Banner.paginate page: params[:page]
  end

  # GET /banneres/1
  def show
    @banner = Banner.find(params[:id])
  end

  # GET /banneres/new
  def new
    @banner = Banner.new
  end

  # GET /banneres/1/edit
  def edit
    @banner = Banner.find(params[:id])
  end

  # POST /banneres
  def create
    @banner = Banner.new(params[:banner])

    if @banner.save
      redirect_to(@banner, notice: 'Banner criado com sucesso.')
      
    else
      render action: "new"
    end
  end

  # PUT /banneres/1
  def update
    @banner = Banner.find(params[:id])

    if @banner.update_attributes(params[:banner])
      redirect_to(@banner, notice: 'Banner atualizado com sucesso.')
      
    else
      render action: "edit"
    end
  end

  # DELETE /banneres/1
  def destroy
    @banner = Banner.find(params[:id])
    @banner.destroy

    redirect_to banneres_url
  end
	def ordenar
		@list = controller_name.classify.constantize.order(:position)
		if request.post?
			@list.each do |m|
				m.position = params[controller_name.singularize].index(m.id.to_s) + 1
				m.save
			end
			render :nothing => true
		end
	end

end