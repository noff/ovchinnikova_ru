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

set :default_environment,
    "RUBY_VERSION" => "ruby 2.4.4"
