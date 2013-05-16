(function() {

  window.Kent = {
    subscriptions: [],

    subscribe: function(subscriptionId, callback) {
      this.subscriptions.push([subscriptionId, callback]);
    },

    runCallbacks: function(subscriptionId, message) {
      for (var i=0; i < this.subscriptions.length; i++) {
        var currentSubscriptionId = this.subscriptions[i][0];
        var callback = this.subscriptions[i][1];
        if (currentSubscriptionId == subscriptionId)
          callback(message);
      }
    }
  }

  $.fn.kentCallbacks = function() {
    var callbacks = $(this).data("kentCallbacks");
    if (typeof(callbacks) === "undefined") callbacks = [];
    return callbacks;
  }

  $.fn.kentReady = function(callback) {
    var $self = $(this);
    var callbacks = $self.kentCallbacks();
    callbacks.push(callback);
    $self.data("kentCallbacks", callbacks);
  }

  $.fn.runKentCallbacks = function(newItem) {
    var callbacks = $(this).kentCallbacks();
    for (var i=0; i < callbacks.length; i++)
      callbacks[i].call(newItem);
  }

  $.fn.replaceWithPush = function(a) {
      var $a = $(a);
      this.replaceWith($a);
      return $a;
  };

  function autoClosingFayeSubscription(subscriptionId, callback) {
    var fayeSubscription = kentClient.subscribe('/' + subscriptionId, function(message) {
      callback(message);
      fayeSubscription.cancel();
    });
  }

  $(function() {
    window.kentClient = new Faye.Client('http://localhost:9292/faye');

    $(".kent-container").each(function() {
      var $self = $(this);
      var subscriptionId = $self.attr("id");

      autoClosingFayeSubscription(subscriptionId, function(message) {
        var $message = $(message);
        $self.runKentCallbacks($message);
        $self.replaceWithPush($message);
        Kent.runCallbacks(subscriptionId, $message);
      });

    });
  });

})();