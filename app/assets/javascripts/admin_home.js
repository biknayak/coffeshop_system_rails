jQuery(document).ready(function() {
    $('.message .close')
        .on('click', function () {
            $(this).closest('.message').transition('fade');
        });

});

jQuery(document).on("turbolinks:load",function () {
    if(!$(".admin_home.index").length > 0){
        return
    }
    App.Channels.admin_home.subscribe()
});
