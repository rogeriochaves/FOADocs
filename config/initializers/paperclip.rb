# heroku

=begin
if Rails.env == 'production'

	s3_config = YAML.load(ERB.new(File.read("#{Rails.root}/config/s3.yml")).result)[Rails.env] 

	Paperclip::Attachment.default_options.merge!(
		:storage => :aws,
	    :s3_credentials => {
	      :access_key_id => s3_config['access_key_id'],
	      :secret_access_key => s3_config['secret_access_key'],
	      :endpoint => s3_config['endpoint']
	    },
	    :s3_bucket => s3_config['bucket'],
	    :s3_permissions => :public_read,
	    :s3_protocol => 'http',
	    :s3_options => {
	      :server_side_encryption => 'AES256',
	      :storage_class => :reduced_redundancy,
	      :content_disposition => 'attachment'
	    },
	    :s3_headers => { 'Cache-Control' => 'max-age=315576000', 'Expires' => 10.years.from_now.httpdate },
	    :path => s3_config['bucket'] + "/:id/:style/:basename.:extension"
	)

end
=end