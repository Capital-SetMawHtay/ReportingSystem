$(function(){
//$('#chat_container .content:first').addClass('active');
    var $target=$('#chat_notification');
    $target.find('a').on('click',function(){
        $('#chat_notification span').text('0');
    });
jQuery.fn.notifyChat= function(){

    var val = $target.text();
    $target.find('span').text(parseInt(val)+1);
};
jQuery.fn.tabClick = function(){
   this.on('click',function(){
       var gid = $(this).data('gid');
       $('#message_group_id').val(gid);
        $('#new_message').show();
   });

}
$('#new_message').hide();
    jQuery.fn.groupClick = function(){
      this.on('click',function(){
          var gid = $(this).data('gid');
          var uid = $(this).data('uid');
          $.ajax({
             url: '/users/'+uid+'/groups/'+gid+'/open'
          });
          $('.tmgt-chat-box').text('Loading');
          $.ajax({
              url: '/messages',
              data: {group_id: gid},
              dataType: "script"
          });
          var t = $(this).find('.name').text();
          $('#current_group').text(t);
      });
        return this;
  };
    $('dd a').tabClick();
    $('.use_group').groupClick();

});