$('document').ready(function(){
    $('.team_transfer_form').hide();
    $('.transfer_link').on('click',function(){
        console.log("hiding");
       $(this).hide();
       $(this).siblings('.team_transfer_form').slideDown();
    });
})

