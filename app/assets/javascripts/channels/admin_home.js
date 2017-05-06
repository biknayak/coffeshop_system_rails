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
    if(data.state == "add")
    {
      var html=''
      html+='<table class="table table-hover" id="'+data.order.id+'">'
      html+='<thead><tr><th>Order Date</th><th>Name</th><th>Room</th><th>EXT.</th><th>Action</th</tr></thead>'
      html+='<tbody><tr><td>'+data.order.created_at+'</td><td>'+data.user.first_name+' '+''+data.user.last_name+'</td>'
      html+='<td>'+data.room+'</td><td>'+data.user.extension+'</td><td><a href=/adminHome/change/'+data.user.id+'/'+data.order.id+'>Deliver</a></td></tr><tr>'
      html+='<tr><td colspan=4><div id="orderProducts" class="clear" >'
      data.productsinfo.forEach(function(product,i){
        html+='<div class="col-md-2 column productbox">'
        html+='<img src="'+product.Image.url+'" class="img-responsive">'
        html+='<div class="producttitle">'+product.name+'</div>'
        html+='<div class="productprice"><div class="pull-left">'+data.products[i].quantity+'</div><div class="pricetext bg-primary text-white pull-right">'+product.price+" LE"+'</div></div></div>'
      });
      html+='</div></td><td><span class="label label-info" >Total:EGP'+data.order.total_price+'</span></td></tr></tbody></table>'

      $('#onServiceOrders').prepend(html)
    }else {
      $('#'+data.orderID).remove()
    }
  }
});
}
