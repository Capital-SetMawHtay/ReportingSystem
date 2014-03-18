$(function(){
$('#new_message').hide();
  $('.use_group').on('click',function(){
  $('#new_message').show();
    $('#message_group_id').attr('value',$(this).data('gid'));
    var t = $(this).find('.name').text();
    $('#current_group').text(t);
});
});