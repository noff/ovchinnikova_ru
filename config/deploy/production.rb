# frozen_string_literal: true

set :user, "ovchinnikova"
server "ovchinnikova.ru", user: fetch(:user), roles: %w[app db web]

set :ssh_options,
    forward_agent: true,
    port: 21212

set :application, "ovchinnikova"
set :deploy_to, "/home/ovchinnikova/#{fetch(:application)}"
set :branch, "production"
set :rails_env, "production"

set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, 'v15.0.1'
set :nvm_map_bins, %w{node npm yarn}

set :default_environment,
    "RUBY_VERSION" => "ruby 2.7.0"
