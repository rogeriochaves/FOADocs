class GoogleDriveController < ApplicationController

	def index
		#client = Google::APIClient.new(:application_name => 'FOADocs', :application_version => '1.0.0')
		google = GoogleDrive.new

		render :text => :ok
	end

end
