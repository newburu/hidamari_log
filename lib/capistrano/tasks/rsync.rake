namespace :load do
  task :defaults do
    set :rsync_options, %w[--recursive --delete --delete-excluded --exclude .git* --exclude node_modules --exclude .kamal --exclude tmp --exclude log]
    set :rsync_src, "."
  end
end

namespace :dummy do
  task :check do
    run_locally do
      unless test :which, :rsync
        error "rsync is not installed locally!"
        exit 1
      end
    end
  end

  task :create_release do
    invoke "dummy:sync"
  end

  task :set_current_revision do
    run_locally do
      set :current_revision, `git rev-parse HEAD`.strip
    end
  end

  task :sync do
    on roles(:all) do |role|
      # Build the rsync command
      # Note: We use the role's properties to construct the destination
      user_host = role.user ? "#{role.user}@#{role.hostname}" : role.hostname
      dest = "#{user_host}:#{release_path}/"

      # Use SSH options from config if needed, but rsync usually relies on .ssh/config
      # Since we set up rails-server alias, it should work.

      run_locally do
        execute :rsync, *fetch(:rsync_options), fetch(:rsync_src) + "/", dest
      end
    end
  end
end

if Rake::Task.task_defined?("git:check")
  Rake::Task["git:check"].clear
  task "git:check" do; end
end
