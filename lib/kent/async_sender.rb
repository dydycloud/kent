require 'net/http'

module Kent
  class AsyncSender

    class << self
      attr_accessor :queue

      def queue
        @queue ||= Kent.resque_queue
      end
    end

    def self.perform(loader_name, generated_id)
      loader = loader_name.constantize
      sender.publish("/#{generated_id}", template(loader))
    end

    def self.template(loader)
      loader.new.render_template
    end

    def self.sender
      Kent::Faye.new
    end

  end
end