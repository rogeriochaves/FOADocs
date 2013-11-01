require 'bundler/capistrano'
#require 'whenever/capistrano'

# General
set :application, "AppName"
set :user, "reactweb"
set :pasta, "reactweb"
set :domain, "142.4.214.14"
set :deploy_to, "/home/#{pasta}/#{application}" 
set :copy_exclude, %w(.git/* .svn/* log/* tmp/* .gitignore *.DS_Store public/system/* public/system vendor/bundle)
set :keep_releases, 5
set :test_log, "log/test.log"

# GIT
set :scm, :git
set :scm_username, user
set :scm_verbose, true
set :repository, "#{user}@#{domain}:/home/#{pasta}/#{application}"
set :branch, 'master'
set :use_sudo, false

# Roles
set :server_name, domain
role :app, server_name
role :web, server_name
role :db, server_name, :primary => true

# SSH
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:paranoid] = true # comment out if it gives you trouble. newest net/ssh needs this set.

# Tasks

namespace :passenger do
  desc "Restart Application"  
  task :restart do  
    run "touch #{current_path}/tmp/restart.txt"  
  end
end

# Run tests
namespace :deploy do
  before 'deploy:update_code' do
    puts "--> Running tests, please wait ..."
    unless system "bundle exec rake test:all > #{test_log} 2>&1" #' > /dev/null'
      puts "--> Tests failed. Run `cat #{test_log}` to see what went wrong."
      exit
    else      
      puts "--> Tests passed"
      system "rm #{test_log}"
    end
  end
end

#after "deploy:update", "deploy:cleanup"
after :deploy, "deploy:migrate"
after :deploy, "passenger:restart"