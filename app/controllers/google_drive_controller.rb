# class GoogleDriveController < ApplicationController

# 	def index
# 		#client = Google::APIClient.new(:application_name => 'FOADocs', :application_version => '1.0.0')
# 		google = GoogleDrive.new

# 		render :text => :ok
# 	end

# end


class GoogleDriveController < Devise::OmniauthCallbacksController
	def google_oauth2
	    # You need to implement the method below in your model (e.g. app/models/user.rb)
	    @user = Usuario.find_for_google_oauth2(request.env["omniauth.auth"])

	    if @user.persisted?
	      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
	      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
	    else
	      session["devise.facebook_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end
	end
end