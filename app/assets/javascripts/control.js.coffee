$menu_btn = $('.tab-bar-section span i')
$offcanvas_btn = $('#off-canvas-btn')
$offcanvas_parent = $('#tmgt-off-canvas-parent')
$main_content = $('#main-process')
toggle = true
$custom_scrollbar = $('#custom-scrollbar')

# this offcanvas menu did not relate with foundation built in off-canvas menu
$offcanvas_btn.on "click", ->
  if toggle
    $offcanvas_parent.removeClass('tmgt-off-canvas-parent-before').addClass('tmgt-off-canvas-parent-after')
    $main_content.addClass('main-process-after').removeClass('main-process-before')
  else
    $offcanvas_parent.removeClass('tmgt-off-canvas-parent-after').addClass('tmgt-off-canvas-parent-before')
    $main_content.addClass('main-process-before').removeClass('main-process-after')
  toggle = !toggle

$menu_btn.on "click", ->
  $(this).parent().children().removeClass('active')
  #notification sound testing
  song = $('#notification')[0]
  song.play()
  $(this).addClass('active')
# use unbind method to prevent additional call when the item is already activated

#notification triggerring
# TODO: notification will be caused by some of served site chat msg is occurred
# this is just a testing purpose
$menu_btn.append '<div class="tmgt-notification-budge">4</div>'
$menu_btn.on "click", ->
  $(this).find('div').toggleClass('tmgt-notification-budge-after')

#custom scrollbar impl
$custom_scrollbar.mCustomScrollbar({
  scrollButtons:{
    enable:true
  },
  theme:"dark"
})