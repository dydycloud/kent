require 'net/http'

#
# Main class for communication with client.
#
# Usage (example):
#
# faye = Kent::Faye.new(host: "0.0.0.0", port: 9292)
#
# faye.host
#   => "0.0.0.0"
# faye.port
#   => 9292
#
# All fields are optional
#
# faye = Kent::Faye.new
#
# faye.host
#   => "localhost"
# (from Kent.faye_host)
#
# faye.port
#   => 9292
# (from Kent.faye_port)
#
# "host" and "port" fields are used for building URI
#
# faye = Faye.new
# faye.uri
#   => #<URI::HTTP:0x000000020bc1e0 URL:http://localhost:9292/faye>
#
# Using this URI you can publish to client
#
# faye = Faye.new
# faye.publsh("/channel", { some: of_data })
#

module Kent
  class Faye

    attr_accessor :host, :port

    def initialize(options = {})
      @host = options[:host] || Kent.faye_host
      @port = options[:port] || Kent.faye_port
    end

    # Returns URI for faye server
    #
    # @return [URI::HTTP]
    #
    def uri
      URI.parse("http://#{@host}:#{@port}/faye")
    end

    # Method for publishing to clients
    #
    # @param channel [String]
    # @param body [Hash, String, Fixnum] body that respond to 'to_json' method
    #
    def publish(channel, body)
      Net::HTTP.post_form(uri, :message => build_message(channel, body).to_json)
    end

    def build_message(channel, body)
      {
        :channel => channel,
        :data => body
      }
    end

  end
end