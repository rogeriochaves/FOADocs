ruby "2.0.0"
source 'http://rubygems.org'

gem 'rails', '4.0.0'

gem 'json', '1.7.7'
gem 'rack-cache'

# preprocessors
gem 'sass', '~> 3.2.5'
gem 'sass-rails'
gem 'rails-sass-images'
# compressors
gem 'uglifier', '>= 1.0.3'
gem 'yui-compressor'
gem 'sprockets-image_compressor'
# package management para html/css/js
gem 'bower-rails', :github => '42dev/bower-rails'

group :development do
    gem 'certified', github: 'stevegraham/certified'
    gem 'capistrano', '2.11.2'
    gem 'mysql2'
    # fake generator
    gem 'faker'
    gem 'brfaker'

    # live reload
    gem 'guard'
    gem 'guard-livereload'
    gem 'rack-livereload'
    gem 'rb-fsevent'

    gem 'letter_opener'
    gem 'better_errors'
end

group :test do
    gem 'sqlite3'
    gem 'mocha', :require => false
    gem 'simplecov'
    #gem 'ruby-prof'
    #gem 'factory_girl_rails'
    #gem 'faker'
    #gem 'timecop'
end

gem 'dalli'
group :production do
	# heroku
	gem 'unicorn'
	gem 'pg', '0.13.2'
	gem 'execjs'
	gem 'therubyracer'
	gem 'aws-sdk'
	gem 'paperclip-aws', :github => 'rogeriochaves/paperclip-aws'
	gem 'paperclip-compression'
end

gem 'jquery-rails'

# formulários
gem 'protected_attributes', :github => 'rails/protected_attributes', :ref => '11747686c9a'
gem 'simple_form', '>= 3.0.0.rc'
gem 'client_side_validations', :github => 'bcardarella/client_side_validations', :branch => '4-0-beta'
gem 'client_side_validations-simple_form', :github => 'rogeriochaves/client_side_validations-simple_form'
gem 'ckeditor_rails', :github => 'tsechingho/ckeditor-rails'
gem 'nested_form', :github => 'ryanb/nested_form'
gem 'paperclip'
gem 'recaptcha', :require => 'recaptcha/rails'

gem 'heroku'
gem 'devise'
gem 'cancan'
gem 'will_paginate'
gem 'brazilian-rails'
gem 'exception_notification', :github => "rails/exception_notification", :require => 'exception_notifier'
gem 'turbolinks'
gem 'jquery-turbolinks'

#gem 'signet', github: 'krautcomputing/signet'#, branch: 'token_credential_uri_as_hash'
gem "omniauth-google-oauth2"
gem 'google-api-client', github: 'google/google-api-ruby-client'#'0.7.0.rc2'

# Background Jobs
gem 'sucker_punch', '~> 1.0'
gem 'diffy'
gem 'yomu'
