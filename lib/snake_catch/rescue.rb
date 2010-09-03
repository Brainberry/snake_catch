# encoding: utf-8

module SnakeCatch
  module Rescue
    def self.included(target)
      target.extend(ClassMethods)
      target.skip_exception_notifications false
    end
 
    module ClassMethods
      def exception_data(deliverer=self)
        if deliverer == self
          read_inheritable_attribute(:exception_data)
        else
          write_inheritable_attribute(:exception_data, deliverer)
        end
      end
      
      def skip_exception_notifications(boolean=true)
        write_inheritable_attribute(:skip_exception_notifications, boolean)
      end
      
      def skip_exception_notifications?
        read_inheritable_attribute(:skip_exception_notifications)
      end
    end
 
  private
   
    def rescue_action_in_public(exception)
      super
      notify_about_exception(exception) if deliver_exception_notification?
    end
    
    def deliver_exception_notification?
      !self.class.skip_exception_notifications? && ![404, "404 Not Found"].include?(response.status)
    end
    
    def notify_about_exception(exception)
      deliverer = self.class.exception_data
      data = case deliverer
        when nil then {}
        when Symbol then send(deliverer)
        when Proc then deliverer.call(self)
      end
   
      SnakeCatch::Notifier.perform(request.env, exception, data, self)
    end
  end
end
