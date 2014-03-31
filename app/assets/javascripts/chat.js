$(function(){
$('#new_message').hide();
    jQuery.fn.groupClick = function(){
      this.on('click',function(){
          var gid = $(this).data('gid');
          var uid = $(this).data('uid');
          $('#new_message').show();
          $('#message_group_id').val = gid;
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
    $('.use_group').groupClick();

});