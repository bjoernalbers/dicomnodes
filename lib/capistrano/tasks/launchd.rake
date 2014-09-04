namespace :launchd do
  def launchd_dir
    @launchd_dir ||= Pathname.new('/Library/LaunchDaemons')
  end

  def plist_for(service)
    launchd_dir.join("de.dicomnodes.#{service}.plist")
  end

  desc 'Setup Launch Daemons'
  task :setup do
    on roles(:app) do
      fetch(:services).each do |service|
        template2 "#{service}_launchd.erb", plist_for(service)
      end
    end
  end

  desc 'Load Launch Daemons'
  task :load => :setup do
    on roles(:app) do
      fetch(:services).each do |service|
        execute :sudo, :launchctl, 'load -w', plist_for(service)
      end
    end
  end

  desc 'Unload Launch Daemons'
  task :unload => :setup do
    on roles(:app) do
      fetch(:services).each do |service|
        execute :sudo, :launchctl, 'unload -w', plist_for(service)
      end
    end
  end
end
