#set :whenever_command, "bundle exec whenever"
#require "whenever/capistrano"
set :default_environment, {
      'PATH' => "/home/deploy/.rvm/gems/ruby-1.9.3-p194@rails328/bin/:$PATH"
    }

#require "bundler/capistrano"
#require "delayed/recipes"

set :application, "skilldeveloping.com"
set :repository,  "https://railsbasic.googlecode.com/svn/trunk/show"

set :scm, :subversion

role :web, application
role :app, application
role :db,  application, :primary => true

set :user, "deploy"
set :use_sudo, false
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  #desc "Symlink extra configs and folders."
  #task :symlink_extras do
  #  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  #  run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
  #end

  #desc "Setup shared directory."
  #task :setup_shared do
  #  run "mkdir #{shared_path}/assets"
  #  run "mkdir #{shared_path}/config"
  #  run "mkdir #{shared_path}/db"
  #  put File.read("config/examples/database.yml"), "#{shared_path}/config/database.yml"
  #  put File.read("config/examples/app_config.yml"), "#{shared_path}/config/app_config.yml"
  #  puts "Now edit the config files and fill assets folder in #{shared_path}."
  #end

end

#after "deploy:setup", "deploy:setup_shared"
#after "deploy:update_code", "deploy:symlink_extras"
#after "deploy", "deploy:cleanup" # keeps only last 5 releases
#after "deploy:cleanup", "deploy:restart"
#
#Delayed Job
#before "deploy:restart", "delayed_job:stop"
#after  "deploy:restart", "delayed_job:start"
#after  "deploy:stop", "delayed_job:stop"
#after  "deploy:start", "delayed_job:start"


