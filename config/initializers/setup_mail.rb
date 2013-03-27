if Rails.env == "production"

	ActionMailer::Base.delivery_method = :sendmail 
	ActionMailer::Base.sendmail_settings = {
	    :location       => '/usr/sbin/sendmail',
	    :arguments      => '-i -t'
	}
# heroku
=begin
	ActionMailer::Base.smtp_settings = {
	  :address        => 'smtp.sendgrid.net',
	  :port           => '587',
	  :authentication => :plain,
	  :user_name      => ENV['SENDGRID_USERNAME'],
	  :password       => ENV['SENDGRID_PASSWORD'],
	  :domain         => 'heroku.com'
	}
	ActionMailer::Base.delivery_method = :smtp
=end
elsif Rails.env == "test"
	ActionMailer::Base.delivery_method = :test
else
	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.perform_deliveries = true
	ActionMailer::Base.raise_delivery_errors = true


	ActionMailer::Base.smtp_settings = {
	  :address              => "smtp.gmail.com",
	  :port                 => 587,
	  :domain               => "gmail.com",
	  :user_name            => "email4sendgrid@gmail.com",
	  :password             => "1234mudar",
	  :authentication       => "plain",
	  :enable_starttls_auto => true
	}
end

ActionMailer::Base.default :from => "Contato do Site <webmaster@#{AppAdmin.domain}>"
ActionMailer::Base.default_url_options = { :host => "www.#{AppAdmin.domain}" }