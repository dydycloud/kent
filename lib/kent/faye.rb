require 'net/http'

#
# Main class for communication with client.
#
# @example Usage example:
#
#   faye = Kent::Faye.new(host: "0.0.0.0", port: 9292)
#
#   faye.host # => "0.0.0.0"
#   faye.port # => 9292
#
# @example All fields are optional:
#   # If no data passed, values will be taken from:
#   # host: Kent.faye_host
#   # port: Kent.faye_port
#
#   faye = Kent::Faye.new
#   faye.host # => "localhost" (from Kent.faye_host)
#   faye.port # => 9292 (from Kent.faye_port)
#
# @example `host` and `port` fields are used for building URI:
#
#   faye = Kent::Faye.new
#   faye.uri
#   # => #<URI::HTTP:0x000000020bc1e0 URL:http://localhost:9292/faye>
#
# @example Using this URI you can publish to client:
#
#   faye = Kent::Faye.new
#   faye.publsh("/channel", { some: data })
#

class Kent::Faye

  # @attr_reader host [String] host of Faye server
  #
  # Default value: Kent.faye_host
  #
  # @see Kent::Configuration
  #
  attr_reader :host

  # @attr_reader port [Fixnum or String] port of Faye server
  #
  # Default value: Kent.faye_port
  #
  # @see Kent::Configuration
  #
  attr_reader :port

  # Initialize method
  #
  # @param options [Hash]
  # @option options [String] :host host of Faye server
  # @option options [Fixnum] :port port of Faye server
  #
  # @see #host
  #
  # @see #port
  #
  def initialize(options = {})
    @host = options[:host] || Kent.faye_host
    @port = options[:port] || Kent.faye_port
  end

  # Returns URI for faye server
  # Build URI from host and port accessors
  #
  # @see #host
  # @see #port
  # @return [URI::HTTP]
  #
  def uri
    URI.parse("http://#{@host}:#{@port}/faye")
  end

  # Method for publishing to clients
  #
  # @param channel [String]
  # @param body [Object] body that respond to 'to_json' method
  #
  def publish(channel, body)
    Net::HTTP.post_form(uri, :message => build_message(channel, body).to_json)
  end

  # Method for building message
  #
  # @return [Hash] message
  #
  def build_message(channel, body)
    { :channel => channel, :data => body }
  end

end
