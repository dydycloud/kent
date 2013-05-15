require 'net/http'

# Base Kent worker.
#
# Usage:
#
# Resque.enqueue(Kent::AsyncSender, "Some::Loader", "some-uniq-id")
#
# This worker can render template and send it to client
#

module Kent
  class AsyncSender

    class << self
      attr_accessor :queue

      def queue
        @queue ||= Kent.resque_queue
      end
    end

    # Base perform method
    #
    # @param loader_name [String] name of loader
    # @param generated_id [String]
    #
    def self.perform(loader_name, generated_id)
      loader = loader_name.constantize
      sender.publish("/#{generated_id}", template(loader))
    end

    # Returns template from loader
    #
    # @param loader [Kent::Loader]
    #
    def self.template(loader)
      loader.new.render_template
    end

    # Returns class for communication with client
    #
    def self.sender
      Kent::Faye.new
    end

  end
end