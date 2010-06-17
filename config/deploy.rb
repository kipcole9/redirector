set :application,   "redirector"
set :app_dir,       "/u/apps"
set :config_dir,    "#{app_dir}/#{application}/config"
set :db_config,     "#{config_dir}/database.yml"
set :tracker,       "/u/apps/trackster/production/current/public/javascripts/tracker_packaged.js"

# Use Git source control
set :scm, :git
set :repository, "git@github.com:kipcole9/redirector.git"
default_environment["PATH"] = "/opt/ruby-enterprise/bin:$PATH"

# Deploy from master branch by default
set :branch, "master"
#set :scm_verbose, true

set :user, 'kip'
ssh_options[:forward_agent] = true
ssh_options[:port] = 9876
default_run_options[:pty] = true

role :app, "917rsr.traphos.com"

after 'deploy:update_code', 'update_config'
after 'deploy:update_code', 'symlink_tracker_code'

namespace :deploy do
  desc "Restarting passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with passenger"
    task t, :roles => :app do ; end
  end
end

desc "Symlink tracker production javscript"
task :symlink_tracker_code, :roles => :app do  
  run "ln -s #{tracker} #{release_path}/public/_tks.js"
end

# Secure config files
desc "Link production configuration files"
task :update_config, :roles => :app do
  run "ln -s #{db_config} #{release_path}/config/database.yml"
end
