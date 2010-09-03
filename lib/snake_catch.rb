# encoding: utf-8
module SnakeCatch
  autoload :Middleware, 'snake_catch/middleware'
  autoload :Notifier,   'snake_catch/notifier'
  autoload :Issue,      'snake_catch/issue'
  autoload :Rescue,     'snake_catch/rescue'
  
  mattr_accessor :project_key
  @@project_key = "demo"
  
  mattr_accessor :ignore_exceptions
  @@ignore_exceptions = []
  
  def self.default_ignore_exceptions
    [].tap do |exceptions|
      exceptions << ActiveRecord::RecordNotFound if defined? ActiveRecord
      exceptions << AbstractController::ActionNotFound if defined? AbstractController
      exceptions << ActionController::RoutingError if defined? ActionController
    end
  end
  
  def self.all_ignore_exceptions
    [default_ignore_exceptions, @@ignore_exceptions].flatten
  end
    
  # Default way to setup SnakeCatch.
  def self.setup
    yield self
  end
end

require 'snake_catch/railtie'
