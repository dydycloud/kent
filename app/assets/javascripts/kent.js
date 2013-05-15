(function() {

  $(function() {
    kent_client = new Faye.Client('http://localhost:9292/faye');

    $(".kent-container").each(function() {
      var self = $(this);
      var subscription_id = self.attr("id");

      var faye_subscription = kent_client.subscribe('/' + subscription_id, function(message) {
        self.replaceWith(message);
        faye_subscription.cancel();
      });
    });
  });

})();