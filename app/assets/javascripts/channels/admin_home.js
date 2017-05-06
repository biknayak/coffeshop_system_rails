if(!window.App.Channels){
    window.App.Channels = {}
}
if(!window.App.Channels.admin_home){
    window.App.Channels.admin_home={}
}
App.Channels.admin_home.subscribe = function(){ App.cable.subscriptions.create("AdminHomeChannel",{
  connected: function(){
    // Called when the subscription is ready for use on the server
    console.log("subscribed to channel adminHome")
  },
  disconnected: function(){
    // Called when the subscription has been terminated by the server
  },
  received: function(data){
    console.log(data)
    var html=''
    html+='<table class="table table-hover" id="'+data.order.id+'">'
    html+='<thead><tr><th>Order Date</th><th>Name</th><th>Room</th><th>EXT.</th><th>Action</th</tr></thead>'
    html+='<tbody><tr><td>'+data.order.created_at+'</td><td>'+data.user.first_name+' '+''+data.user.last_name+'</td>'
    html+='<td>'+data.room+'</td><td>'+data.user.extension+'</td><td><a href="#">Deliver</a></td></tr><tr>'
    $('#onServiceOrders').prepend(html)
  }
});
}
