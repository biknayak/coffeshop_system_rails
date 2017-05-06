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

jQuery(document).on("turbolinks:load",function () {
    if(!$(".orders.new").length > 0){
        return
    }
    App.Channels.user_orders.subscribe()
});

function getProducts(orderID)
{
  if ($('#'+orderID+' span').hasClass('glyphicon-plus'))
  {
    $.ajax({
        type: "GET",
        url: '/order/products/'+orderID,
        dataType: "JSON",
        success: function(data) {
          console.log(data)
          changebutton(orderID,data)
        }
      });
  }else {
    $('.clear').empty();
    $('#'+orderID+' span').removeClass("glyphicon-minus").addClass("glyphicon-plus")
  }
}
function changebutton(buttonid,data){
  $('.glyphicon').each(function(){
    if ($(this).attr("name") === buttonid)
    {
          $(this).toggleClass("glyphicon-plus glyphicon-minus")
          displayProducts(data)
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

function getOrders(start,end)
{
  console.log(start)
  console.log(end)
  var endDate = end
  if(!end)
  {
    var endDate = new Date();
    var dd = endDate.getDate();
    var mm = endDate.getMonth()+1;
    var yyyy = endDate.getFullYear();
    if(dd<10){
      dd='0'+dd;
    }
    if(mm<10){
      mm='0'+mm;
    }
    var endDate = yyyy+'-'+mm+'-'+dd;
  }

  if(start)
  {
    $.ajax({
        method: 'get',
        url: "/orders/"+ start + '/' + endDate,
        success:function(data){
          if(data.length == 0)
          {
            $('#warning').remove()
            $('tbody').empty()
            $('tbody').prepend('<div id="warning"><tr colspan=4><h3><span class="label label-default">No Results Found </span></h3></tr></div><br>')
          }else {
            console.log(data)
            $('#warning').remove()
            displayOrders(data)
          }
        }
    });
  }
}

function displayOrders(data)
{
  $('.orderInfo').remove()
  html=''
  data.forEach(function(order){
    html+='<tr id="'+order.id+'" class="orderInfo">'
    html+='<td>'+order.created_at+'<button type="button" class="btn btn-default btn-sm"  id= "'+order.id+'" onclick="getProducts(this.id)">'
    html+='<span class="glyphicon glyphicon-plus" name= "'+order.id+'"></span></button></td>'
    html+='<td>'+order.status+'</td><td>'+order.total_price+'</td><td>'
    if(order.status == "processing")
    {
        html+='<a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/orders/'+order.id+'">Cancel</a>'
    }
    html+='</td></tr>'
  });
  $('tbody').prepend(html)
}
