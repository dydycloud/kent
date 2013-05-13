require 'net/http'

module Kent
  class Faye

    attr_accessor :host, :port

    def initialize(options = {})
      @host = options[:host] || Kent.faye_host
      @port = options[:port] || Kent.faye_port
    end

    def uri
      URI.parse("http://#{@host}:#{@port}/faye")
    end

    def publish(channel, body)
      message = {
        :channel => channel,
        :data => body
      }
      Net::HTTP.post_form(uri, :message => message.to_json)
    end

  end
end