jQuery(document).ready(function() {
    $('.message .close')
        .on('click', function () {
            $(this).closest('.message').transition('fade');
        });

});

jQuery(document).on("turbolinks:load",function () {
    if(!$(".orders.index").length > 0){
        return
    }
    App.Channels.user_orders.subscribe()
});

function getProducts(orderID)
{
$.ajax({
    type: "GET",
    url: '/order/products/'+orderID,
    dataType: "JSON",
    success: function(data) {
      console.log(data)
      changebutton(orderID)
      displayProducts(data)
    }
  });
}
function changebutton(buttonid){
  $('.glyphicon').each(function(){
    if ($(this).attr("name") === buttonid)
    {
        $(this).toggleClass("glyphicon-plus glyphicon-minus")
    }
    else {
      $(this).removeClass("glyphicon-minus")
      $(this).addClass("glyphicon-plus")
    }
  });
}

function displayProducts(infos){
  var html = ''
  if(infos.productsinfo.length != 0)
  {
  infos.productsinfo.forEach(function(product){
    html+='<div class="col-md-2 column productbox">'
    html+='<img src="'+product.Image.url+'" class="img-responsive">'
    html+='<div class="producttitle">'+product.name+'</div>'
    infos.products.forEach(function(pr){
      if (pr.product_id == product.id)
      {
        html+='<div class="productprice"><div class="pull-left">'+pr.quantity+'</div><div class="pricetext bg-primary text-white pull-right">'+product.price+" LE"+'</div></div>'
      }
    });
    html+='</div>'
  });
    $('.clear').empty();
    $('#orderProducts').prepend(html);
    $('#amount').prepend('<span class="label label-info" >'+"Total "+infos.total_price+'</span>');
  }
}
