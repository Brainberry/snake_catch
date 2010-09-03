# encoding: utf-8
require 'curl'

module SnakeCatch
  class Issue
    attr_accessor :backtrace
    attr_accessor :request
    attr_accessor :session
    attr_accessor :environment
    attr_accessor :exception
    attr_accessor :data
    attr_accessor :controller
    
    SPLITER = '|'
    
    def initialize(env, exception, data = nil, controller = nil)
      @env = env
      @exception = exception
      @data = data
      @request = ::Rack::Request.new(env)
      @controller = controller
    end
    
    def params
      @params = []
      
      host = (@env["HTTP_X_FORWARDED_HOST"] || @env["HTTP_HOST"])
      
      @params << Curl::PostField.content('exception[class]', @exception.class)
      @params << Curl::PostField.content('exception[message]', @exception.message)
      
      @params << Curl::PostField.content('request[url]', @request.url)
      @params << Curl::PostField.content('request[host]', host)
      @params << Curl::PostField.content('request[parameters]', @request.params.inspect)
      
      if @controller.respond_to?(:controller_name)
        @params << Curl::PostField.content('controller', @controller.controller_name)
        @params << Curl::PostField.content('action', @controller.action_name)
      end
      
      @params << Curl::PostField.content('session', @request.session.inspect)
      @params << Curl::PostField.content('backtrace', sanitize_backtrace(@exception.application_backtrace))
      @params << Curl::PostField.content('environment', sanitize_environment(@env))
      @params << Curl::PostField.content('data', @data.inspect)
      
      @params
    end
    
    private
      
      def sanitize_environment(env)
        lines = []
        env.each do |key, value|
          lines << [key, clean_unserializable_data(value).inspect ].join(":")
        end
        lines.join(SPLITER)
      end
      
      # Removes non-serializable data. Allowed data types are strings, arrays,
      # and hashes. All other types are converted to strings.
      def clean_unserializable_data(data)
        if data.respond_to?(:to_hash)
          data.to_hash.inject({}) do |result, (key, value)|
            result.merge(key => clean_unserializable_data(value))
          end
        elsif data.respond_to?(:to_ary)
          data.collect do |value|
            clean_unserializable_data(value)
          end
        else
          data.to_s
        end
      end
      
      def sanitize_backtrace(trace)
        re = Regexp.new(/^#{Regexp.escape(rails_root)}/)
        trace.map { |line| Pathname.new(line.gsub(re, "[RAILS_ROOT]")).cleanpath.to_s }
        trace.join(SPLITER)
      end
     
      def rails_root
        @rails_root ||= Rails.root.cleanpath.to_s
      end
  end
end
