# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'dicomnodes'
set :repo_url, 'git@github.com:bjoernalbers/dicomnodes.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'
set :deploy_to, ->{ File.join('/Users', fetch(:user), fetch(:application)) }

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
#set :pty, true

# Default value for :linked_files is []
#set :linked_files, %w{config/database.yml db/production.sqlite3}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
#set :linked_dirs, %w{storage}

# Launchd-Services
set :services, %w(unicorn)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'launchd:unload'
      invoke 'launchd:load'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
