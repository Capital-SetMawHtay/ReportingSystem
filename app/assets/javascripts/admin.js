$(function(){
   $('.noti_close').on('click',function(){
      $(this).parent().remove();
   });

    jQuery.fn.increseSubmittedCount= function(team){
       var value = $('#count_'+team).text();
       $('#count_'+team).text(parseInt(value)+1);
    };

    jQuery.fn.notifyChat= function(){
        var $target=$('#chat_notification');
        $target.find('a').on('click',function(){
            $('#chat_notification span').text('0');
        });
        var val = $target.text();
        $target.find('span').text(parseInt(val)+1);
    };
});