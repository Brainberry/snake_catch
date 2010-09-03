# encoding: utf-8
require 'rails'
require 'snake_catch'

module SnakeCatch
  class Railtie < ::Rails::Railtie
    config.app_middleware.use 'SnakeCatch::Middleware'
  end
end
