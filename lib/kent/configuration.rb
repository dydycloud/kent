module Kent
  module Configuration

    def self.included(klass)
      class << klass
        attr_accessor :redis, :id_generator, :faye_host, :faye_port

        def id_generator
          @id_generator ||= UUID
        end

        def redis
          @redis ||= Redis.new
        end

        def resque_queue
          @resque_queue ||= :kent_sender
        end

        def faye_host
          @faye_host ||= "localhost"
        end

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