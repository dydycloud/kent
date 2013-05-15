module Kent
  module ViewHelpers

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