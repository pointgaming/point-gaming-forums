server "pg", :app, :web, :db, :primary => true
set :deploy_to, "/srv/point-gaming-forums"

set :use_sudo, false

set :keep_releases, 3

default_run_options[:pty] = true
