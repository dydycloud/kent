#
# Module with view helpers.
#
module Kent::ViewHelpers

  # Main view helper for asyncronous data loading.
  #
  # @param loader [Kent::Loader]
  # @param options [Hash]
  # @option options [String] :class Class of container
  # @option options [String] :subscription_id You can override generated subscription id
  #   (and subscribe to it later)
  # @option options [Hash] :style Style of container
  #
  # @yield block for evaluating
  #
  # @example Basic usage:
  #
  #   async_load MyLoader, class: "my_class", style: { display: "block", color: "red" }
  #   # => <span id="1fcaf530-9fb5-0130-3c4c-102b34ab9b1a" class="my_class kent-container" style="display:block; color:red;"></span>
  #
  # @!parse [ruby]
  # @example You can pass "subscription_id"
  #
  #   async_load MyLoader, class: "my_class", style: { display: "block", color: "red" }, subscription_id: "my_subscription_id"
  #   # => <span id="my_subscription_id" class="my_class kent-container" style="display:block; color:red;"></span>
  #
  #   async_load MyLoader do
  #     "<h1>Loading...</h1>"
  #   end
  #   # => <span id="1fcaf530-9fb5-0130-3c4c-102b34ab9b1a"> <h1>Loading...</h1> </span>
  #
  def async_load(loader, options = {}, &block)
    options.symbolize_keys!

    subscription_id = options[:subscription_id] || ::Kent.id_generator.generate
    klass = Array(options[:class]) + ["kent-container"]
    style = { :display => "none" }.merge(options[:style] || {})
    str_style = style.map { |k,v| "#{k}:#{v}" }.join("; ")

    register_async_loading(loader, subscription_id)

    content_tag :span, :id => subscription_id, :class => klass.join(" "), :style => str_style do
      capture(&block) if block_given?
    end
  end

  # Method for creating background job.
  #
  # @param loader [Kent::Loader]
  # @param subscription_id [String] uniq string (in terms of all user sessions)
  #
  def register_async_loading(loader, subscription_id)
    ::Resque.enqueue(kent_worker, loader.name, subscription_id, params)
  end

  # Returns kent worker
  #
  # @return [Kent::AsyncSender]
  #
  def kent_worker
    Kent::AsyncSender
  end

end