if(!window.App.Channels){
    window.App.Channels = {}
}
if(!window.App.Channels.user_orders){
    window.App.Channels.user_orders={}
}
App.Channels.user_orders.subscribe = function(){ App.cable.subscriptions.create({channel: "UserOrdersChannel"},{
  connected: function(){
    // Called when the subscription is ready for use on the server
    console.log("subscribed to channel")
  },
  disconnected: function(){
    // Called when the subscription has been terminated by the server
  },
  received: function(data){
    if(data.to == "all")
    {
      console.log(data)
      $('#'+data.orderID+' td:nth-child(2)').text(data.state);
      $('#'+data.orderID+' td:nth-child(4)').text('');
    }else{
      console.log(data)
      if(data.state == "unavailable")
      {
        delete_unavailable_product(data.productID)
      }
      else {
        console.log(data.state)
      }
    }
  }
  });
}
