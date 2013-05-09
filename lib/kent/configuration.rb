module Kent
  module Configuration

    def self.included(klass)
      class << klass
        attr_accessor :redis, :id_generator

        def id_generator
          @id_generator ||= UUID
        end

        def configure
          yield self
        end
      end
    end

  end
end