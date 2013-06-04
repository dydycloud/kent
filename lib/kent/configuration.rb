#
# Main configuration module.
#
# @example Usage (all fields are optional):
#
#   Kent.configure do |config|
#     config.redis = Redis.new
#     config.id_generator = UUID
#     config.faye_host = "0.0.0.0"
#     config.faye_port = 9292
#     config.resque_queue = "resque_queue"
#   end
#
module Kent::Configuration

  # Stores redis connection
  #
  # Default value: `Redis.new`
  #
  # @return [Redis]
  #
  attr_accessor :redis

  # Stores ID generator
  #
  # Default value: `UUID`
  #
  # @return [Object] should respond to #generate method
  #
  attr_accessor :id_generator

  # Stores faye host
  #
  # Default value: "localhost"
  #
  # @return [String] Host of faye server
  #
  attr_accessor :faye_host

  # Stores faye port
  #
  # Default value: 9292
  #
  # @return [Fixnum] Port of faye server
  #
  attr_accessor :faye_port

  # Stores name of resque queue
  #
  # Default value: :kent_sender
  #
  # @return [String, Fixnum] Name of resque queue
  #
  attr_accessor :resque_queue

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