module Kent
  module ViewHelpers

    def async_load(loader)
      subscription_id = ::Kent.id_generator.generate

      register_async_loading(loader, subscription_id)

      "<script type='text/javascript'>subscribe_to_async_load('#{subscription_id}')</script>".html_safe
    end

    def register_async_loading(loader, subscription_id)
      Resque.enqueue(kent_worker, loader, subscription_id)
    end

    def kent_worker
      Kent::AsyncSender
    end

  end
end