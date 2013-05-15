module Kent
  module ViewHelpers

    # Main view helper
    #
    # @param loader [Kent::Loader]
    # @param options [Hash]
    # @yield block for evaluating
    #
    # Example:
    #
    # <%= async_load MySuperLoader, class: "my_class", style: { display: "block", color: "red" }
    #   => "<span id='1fcaf530-9fb5-0130-3c4c-102b34ab9b1a' class='my_class kent-container' style='display:block; color:red;'></span>"
    #
    def async_load(loader, options = {}, &block)
      options.symbolize_keys!

      subscription_id = options[:subscription_id] || ::Kent.id_generator.generate
      klass = Array(options[:class]) + ["kent-container"]
      style = { :display => "none" }.merge(options[:style] || {})
      str_style = style.map { |k,v| "#{k}:#{v}" }.join("; ")

      register_async_loading(loader, subscription_id)

      "<span id='#{subscription_id}' class='#{klass.join(" ")}' style='#{str_style};'>#{capture(&block) if block_given?}</span>".html_safe
    end

    def register_async_loading(loader, subscription_id)
      ::Resque.enqueue(kent_worker, loader.name, subscription_id)
    end

    def kent_worker
      Kent::AsyncSender
    end

  end
end

ActiveSupport.on_load :action_view do
  ActionView::Base.send(:include, Kent::ViewHelpers)
end