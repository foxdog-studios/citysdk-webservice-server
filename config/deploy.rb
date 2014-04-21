# XXX: Most for this is cut 'n' paste from server's deploy.rb. Should be
#      centralised.

require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :application, 'citysdk-webservice-server'
set :copy_exclude, ['config.json', 'log', 'tmp']
set :deploy_via, :copy
set :repository,  '.'
set :use_sudo, false
set :user, 'deploy'


# =============================================================================
# = Gem installation                                                          =
# =============================================================================

# XXX: Hack to make Blunder's Capistrano tasks see the RVM. Is there a
#      better way of doing this?
set :bundle_cmd, '/usr/local/rvm/bin/rvm 2.1.1@citysdk do bundle'

# Without verbose it hangs for ages without any output.
set :bundle_flags, '--deployment --verbose'


# =============================================================================

namespace :deploy do
  # Restart Passenger
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end

  task :finalize_update, :except => { :no_release => true } do
    run <<-CMD
      rm -rf #{latest_release}/log &&
      mkdir -p #{latest_release}/public &&
      mkdir -p #{latest_release}/tmp &&
      ln -s #{shared_path}/log #{latest_release}/log &&
      ln -s #{shared_path}/filetmp #{latest_release}/filetmp
    CMD

    run "ln -s #{shared_path}/config/config.json #{release_path}"
  end
end

