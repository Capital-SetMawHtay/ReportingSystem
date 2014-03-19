$(function(){
$('#new_message').hide();
  $('.use_group').on('click',function(){
   var gid = $(this).data('gid');
  $('#new_message').show();
    $('#message_group_id').attr('value',gid);
    $('.tmgt-chat-box').text('Loading');
      $.ajax({
          url: '/messages',
          data: {group_id: gid},
          dataType: "script"
      });
    var t = $(this).find('.name').text();
    $('#current_group').text(t);
});
});