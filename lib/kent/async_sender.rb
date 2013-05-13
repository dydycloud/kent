require 'net/http'

module Kent
  class AsyncSender

    class << self
      attr_accessor :queue

      def queue
        @queue ||= Kent.resque_queue
      end
    end

    def self.perform(loader, generated_id)

    end

    def self.template(loader)
      loader.new.render_template
    end

  end
end