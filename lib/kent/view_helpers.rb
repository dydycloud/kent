module Kent
  module ViewHelpers

    def async_load(loader)
      subscription_id = ::Kent.id_generator.generate

      register_async_loading(loader, subscription_id)

      "<script id='#{subscription_id}' type='text/javascript'>subscribe_to_async_load('#{subscription_id}')</script>".html_safe
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