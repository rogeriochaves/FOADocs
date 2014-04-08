if Rails.env == "production"
	# heroku
	ActionMailer::Base.smtp_settings = {
	  :address        => 'smtp.sendgrid.net',
	  :port           => '587',
	  :authentication => :plain,
	  :user_name      => ENV['SENDGRID_USERNAME'],
	  :password       => ENV['SENDGRID_PASSWORD'],
	  :domain         => 'heroku.com'
	}
	ActionMailer::Base.delivery_method = :smtp
elsif Rails.env == "test"
	ActionMailer::Base.delivery_method = :test
else
	ActionMailer::Base.delivery_method = :letter_opener
end

ActionMailer::Base.default :from => "Contato do Site <webmaster@#{AppAdmin.domain}>"
if Rails.env == "production"
	ActionMailer::Base.default_url_options = { :host => "foadocs.herokuapp.com" }
else
	ActionMailer::Base.default_url_options = { :host => "localhost:3000" }
end