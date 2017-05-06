if(!window.App.Channels){
    window.App.Channels = {}
}
if(!window.App.Channels.user_orders){
    window.App.Channels.user_orders={}
}
App.Channels.user_orders.subscribe = function(){ App.cable.subscriptions.create("UserOrdersChannel",{
  connected: function(){
    // Called when the subscription is ready for use on the server
    console.log("subscribed to channel")
  },
  disconnected: function(){
    // Called when the subscription has been terminated by the server
  },
  received: function(data){
    console.log(data)
  }
  });
}
