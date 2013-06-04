require 'net/http'

# Base Kent worker.
#
# @example Basic usage:
#   Resque.enqueue(Kent::AsyncSender, "Some::Loader", "some-uniq-id")
#
# @example You can pass extra data as last argument (should be serializable):
#   Resque.enqueue(Kent::AsyncSender, "My::Another::Loader", "some-uniq-id", :extra => "parameters")
#
# This worker can render template and send it to client
#
class Kent::AsyncSender
  class << self

    attr_accessor :queue

    # Returns name of queue (in Resque).
    # Default value: Kent.resque_queue
    #
    # @return [String]
    #
    def queue
      @queue ||= Kent.resque_queue
    end

    # Base perform method
    #
    # @param loader_name [String] name of loader
    # @param generated_id [String] id of subscription
    # @param params [Hash] hash of params (params - in terms of view/controller)
    #
    def perform(loader_name, generated_id, params = {})
      loader = loader_name.constantize
      sender.publish("/#{generated_id}", template(loader, params))
    end

    # Returns rendered template (from loader)
    #
    # @param loader [Kent::Loader] loader
    # @param params [Hash] hash of params (params - in terms of view/controller)
    #
    def template(loader, params = {})
      loader.new(params).render_template
    end

    # Returns class for communication with client
    #
    # Can be overriden in subclasses
    #
    # @return [Kent::Faye] (Kent::Faye)
    #
    # @see Kent::Faye
    #
    def sender
      Kent::Faye.new
    end

  end
end
