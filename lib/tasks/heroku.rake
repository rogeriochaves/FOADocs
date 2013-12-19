# encoding: utf-8

namespace :heroku do
	task :deploy => :environment do
		def run(command)
			puts "> #{command}"
			system command
		end
		run "git init"
		run "git add ."
		run "git commit -am \"first commit\""
		run "heroku create #{AppAdmin.app_name.parameterize}"
		run "heroku addons:add sendgrid:starter"
		run "heroku addons:add memcache"
		run "heroku addons:add scheduler:standard"
		run "heroku domains:add www.#{AppAdmin.domain}"
		run "heroku domains:add #{AppAdmin.domain}"
		run "git push heroku master"
		run "heroku run rake db:migrate"
	end
end