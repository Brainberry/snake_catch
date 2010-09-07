# encoding: utf-8
module SnakeCatch 
  class Middleware  
    def initialize(app, options = {})
      @app, @options = app, options
    end
   
    def call(env)
      @app.call(env)
    rescue Exception => exception
      options = (env['snake_catch.options'] ||= {})
      options[:ignore_exceptions] ||= SnakeCatch.all_ignore_exceptions
      options.reverse_merge!(@options)
      
      unless Array.wrap(options[:ignore_exceptions]).include?(exception.class)
        Notifier.perform(env, exception)
      end
   
      raise exception
    end
  end
end
