# config valid for current version and patch releases of Capistrano
lock "~> 3.20.0"

set :application, "hidamari_log"
set :repo_url, "git@github.com:newburu/hidamari_log.git" # Keep for reference or remove if strictly local. rsync plugin uses local directory by default.
# rbenvのパスを明示的に指定します
set :rbenv_path, "/usr/local/src/rbenv"
set :rbenv_type, :user
set :rbenv_ruby, "3.4.5"

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "lib")
set :scm, :dummy
# set :rsync_options ... # Defined in rsync.rake defaults

# Default branch is :master
set :branch, "main"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/hidamari_log"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/master.key", ".env"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
