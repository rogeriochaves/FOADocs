class Admin::EditaveisController < ApplicationController
	before_filter :authenticate_usuario!
	#load_and_authorize_resource

	def update
		@editavel = Editavel.find_by_chave(params[:id])
		if params[:texto]
			@editavel.update_attribute(:texto, params[:texto])
			render :json => {status: "ok"}
		else
			@editavel.update_attributes(params[:editavel])
			redirect_to params[:return_to]
		end
	end
end
