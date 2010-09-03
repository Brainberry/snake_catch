# encoding: utf-8
require 'curl'

module SnakeCatch
  class Notifier    
    class << self
      def perform(env, exception, data = nil, controller = nil)
        em = SnakeCatch::Issue.new(env, exception, data, controller)

        params = em.params
        params << Curl::PostField.content('project_key', SnakeCatch.project_key)
        
        Curl::Easy.http_post("http://localhost:3000", *params)
      end
    end
  end
end
