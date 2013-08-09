source 'http://rubygems.org'

gem 'rails', '3.2.11'

gem 'json', '1.7.7'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'compass-rails'
  gem 'uglifier', '>= 1.0.3'
  gem 'yui-compressor'
  gem 'turbo-sprockets-rails3'
  #gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
end

group :development do
	gem 'capistrano', :github => 'capistrano/capistrano'
	gem 'sqlite3'
	gem 'rails-dev-tweaks'
	gem 'faker'
	gem 'brfaker'

	# live reload
	gem 'guard'
	gem 'guard-livereload'
	gem 'rack-livereload'
	gem 'rb-fsevent'
end

group :test do
	gem 'sqlite3'
	gem 'rspec'
	#gem 'ruby-prof'
	#gem 'factory_girl_rails'
	#gem 'faker'
	#gem 'timecop'
end

gem 'dalli'
group :production do
	# heroku
	#gem 'unicorn'
	#gem 'pg', '0.13.2'
	gem 'mysql2'
	gem 'execjs'
	gem 'therubyracer'
	gem 'aws-sdk'
	gem 'paperclip-aws', :github => 'rogeriochaves/paperclip-aws'
end

# client-side
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-sass', :github => 'thomas-mcdonald/bootstrap-sass', :branch => '3'
#gem 'bootstrap-sass', :github => 'intridea/bootstrap-sass', :branch => '3'

# formulários
gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form', :github => 'dockyard/client_side_validations-simple_form'
gem 'nested_form', :github => 'ryanb/nested_form'
gem 'select2-rails'
gem 'ckeditor', :github => 'rogeriochaves/ckeditor'
gem 'paperclip'
gem 'recaptcha', :require => 'recaptcha/rails'

gem 'devise'
gem 'cancan'
gem 'will_paginate'
gem 'brazilian-rails'
gem 'exception_notification', :github => "rails/exception_notification", :require => 'exception_notifier'
gem 'turbolinks'
gem 'jquery-turbolinks'

# heroku
#gem 'heroku'
