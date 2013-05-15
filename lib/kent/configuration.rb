#
# Usage (example):
#
# Kent.configure do |config|
#   config.redis = Redis.new
#   config.id_generator = UUID
#   config.faye_host = "0.0.0.0"
#   config.faye_port = 9292
#   config.resque_queue = "resque_queue"
# end
#
# All fields are optional.
#

module Kent
  module Configuration

    def self.included(klass)
      class << klass
        attr_accessor :redis, :id_generator, :faye_host, :faye_port, :resque_queue

        # Returns id generator
        # Should respond to 'generate' method
        #
        def id_generator
          @id_generator ||= UUID
        end

        # Returns redis connection
        #
        def redis
          @redis ||= Redis.new
        end

        # Returns resque queue
        #
        # @return [String, Symbol]
        #
        def resque_queue
          @resque_queue ||= :kent_sender
        end

        # Returns faye host
        #
        # @return [String]
        #
        def faye_host
          @faye_host ||= "localhost"
        end

        # Returns faye port
        #
        # @return [Fixnum]
        #
        def faye_port
          @faye_port ||= 9292
        end

        def configure
          yield self
        end
      end
    end

  end
end