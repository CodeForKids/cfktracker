set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '107.170.15.234', user: 'deploy', roles: %w{web app}, ssh_options: { forward_agent: true }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:reload'
  end
end
