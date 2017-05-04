App.user_orders = App.cable.subscriptions.create("UserOrdersChannel",{
  connected: function(){
    // Called when the subscription is ready for use on the server
  },
  disconnected: function(){
    // Called when the subscription has been terminated by the server
  },
  received: function(data){
    console.log(data)
  }
});
