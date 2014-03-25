# heroku

# if Rails.env == 'production'

# 	s3_config = YAML.load(ERB.new(File.read("#{Rails.root}/config/s3.yml")).result)[Rails.env] 

# 	Paperclip::Attachment.default_options.merge!(
# 		:storage => :aws,
# 	    :s3_credentials => {
# 	      :access_key_id => ENV['S3_KEY'],
# 	      :secret_access_key => ENV['S3_SECRET'],
# 	      :endpoint => ENV['S3_ENDPOINT']
# 	    },
# 	    :s3_bucket => ENV['S3_BUCKET'],
# 	    :s3_permissions => :public_read,
# 	    :s3_protocol => 'http',
# 	    :s3_options => {
# 	      :server_side_encryption => 'AES256',
# 	      :storage_class => :reduced_redundancy,
# 	      :content_disposition => 'attachment'
# 	    },
# 	    :s3_headers => { 'Cache-Control' => 'max-age=315576000', 'Expires' => 10.years.from_now.httpdate },
# 	    :path => "#{AppAdmin.app_name}/:class/:id/:style/:basename.:extension",
# 	    :processors => [:thumbnail, :compression]
# 	)

# end