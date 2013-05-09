module Kent
  module Configuration

    def self.included(klass)
      class << klass
        attr_accessor :redis

        def configure
          yield self
        end
      end
    end

  end
end