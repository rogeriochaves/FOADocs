source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'json', '1.7.7'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'compass-rails'
  gem 'uglifier', '>= 1.0.3'
  gem 'yui-compressor'
  gem 'turbo-sprockets-rails3'
end

group :development do
	#gem 'eventmachine', '1.0.0.rc.4'
	#gem 'thin'
	gem 'sqlite3'
	gem 'rails-dev-tweaks'

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
	gem 'unicorn'
	gem 'mysql2'
	#gem 'pg', '0.13.2'
	gem 'execjs'
	gem 'therubyracer'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

# swiss-knive
gem 'capistrano', :github => 'capistrano/capistrano'
gem 'heroku'
gem 'devise'
gem 'cancan'
gem 'will_paginate'
gem 'brazilian-rails'
gem 'paperclip'
gem 'acts_as_list'
gem 'ckeditor', :git => 'git://github.com/rogeriochaves/ckeditor'
gem 'nested_form', :git => 'git://github.com/ryanb/nested_form'
gem 'client_side_validations'
gem 'exception_notification', :git => "git://github.com/rails/exception_notification.git", :require => 'exception_notifier'
gem 'turbolinks'
gem 'jquery-turbolinks'

gem 'aws-sdk'
gem 'paperclip-aws', :git => 'git://github.com/rogeriochaves/paperclip-aws.git'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'
