namespace :setup do
  desc "Upload config files to shared directory"
  task :upload_config do
    on roles(:app) do
      # Ensure config directory exists
      execute :mkdir, "-p", "#{shared_path}/config"

      # Upload files
      upload! "config/database.yml", "#{shared_path}/config/database.yml"
      upload! "config/master.key", "#{shared_path}/config/master.key"

      # Upload .env if it exists
      if File.exist?(".env")
        upload! ".env", "#{shared_path}/.env"
      else
        info ".env file not found locally, skipping."
      end
    end
  end
end
