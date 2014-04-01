# TODO: meetup with backend dev and refactor my spaghetti code 

$menu_btn           	= $('.tab-bar-section span i') 			# this is to append the notification msg in navigation budge menu , FYI: this is jsut a testing purpose 
$offcanvas_btn 			= $('#off-canvas-btn') 					# left-offcanvas menu 
$offcanvas_parent		= $('#tmgt-off-canvas-parent')			# left-offcanvas menu container
$main_content 			= $('#main-process')  					# container of the whole main content
$right_offcanvs_btn 	= $('#off-canvas-right-btn')			# right offcanvas menu
$tooltip_group 			= $('.tmgt-tooltip .wrapper') 			# tooltip wrapper container
toggle 					= true 									# this toggle is used in left offcanvas menu control process
$float_msg 				= $('.tmgt-floating-msg')  				# used in chat page show msg to user to control again and update the chat msg that store in database
$chat_box 				= $('.mCSB_container') 					# this element is used to append the xhr chat data to chat area  .mSCB_container is part from my own module, it's from custom scrollbar plugin html element that is append to chat box area with custom scrollbar script .
notifcicationFire 		= true 									# this is firing notification in right canvas on tablet and mobile mode
$custom_scrollbar 		= $('#tmgt-chat-custom-scrollbar')		# to activate the custom scrollbar plugin script in chat box
$right_canvas_wrapper 	= $('#tmgt-right-canvas-wrapper') 		# control right offcanvas menu animation in mobile potrait and landscpe mode
$user_chat_gruoup		= $('#tmgt-member-group')				# impl custom scroll bar on member group 
$notification_container = $('#tmgt-notification')				# impl custom scroll bar on left offcanvas notification 
$tab_switcher 			= $('#chatbox-tab-switcher dd')			# find the chatbox tab switcher and hide the scroll again to load earliery msg in other tab view when clicking the view
appendHtml 				= '<div class="tmgt-notification-budge">4</div>' # this is the notificatoin msg , FYI: this is just a testing purpose 


# Left Offcanvas impl , this offcanvas menu did not relate with foundation built in off-canvas menu 
$offcanvas_btn.on "click", ->
	if toggle
		$offcanvas_parent.removeClass('tmgt-off-canvas-parent-before').addClass('tmgt-off-canvas-parent-after')		
		$main_content.addClass('main-process-after').removeClass('main-process-before')
	else 
		$offcanvas_parent.removeClass('tmgt-off-canvas-parent-after').addClass('tmgt-off-canvas-parent-before')		
		$main_content.addClass('main-process-before').removeClass('main-process-after')
	toggle = !toggle	

# toggle class when clicking the right offcanvas menu 
# TODO: meetup with backend to program more efficient way 
$right_offcanvs_btn.on "click", ->
	# if notification is appending on right canvas btn in mobile and tablet mode clear that notification area
	element = $(this).parent().find('div')
	if notifcicationFire
		element.removeClass('tmgt-notification-budge-after')
		notifcicationFire = false
	$tooltip_group.toggleClass('tooltip-group-activated')

# this is just a notification sound testing 
# TODO: create utility function to notify the sound 
#$menu_btn.on "click", ->
#	$(this).parent().children().removeClass('active')
#	#notification sound testing
#	song = $('#notification')[0]
#	song.play()
#	$(this).addClass('active')
	# use unbind method to prevent additional call when the item is already activated  


# inject notification to off-canvas-right-btn when user is in mobile or tablet mode to alert the notification is fire on the specifi area eg: in chat group 
# TODO: meetup with backend dev to Notification system 
fireNotification = () ->
	$right_canvas_wrapper.find('div').addClass('tmgt-notification-budge-after')
	#TODO: u must also find and activate the notification sign for the nested children 

# testing purpose , dun need to implement expect mobile mode 
fireNotification()

# notification triggerring
# TODO: notification will be caused by some of served site chat msg is occurred 
# this is just a testing purpose 
# already append the notification class before used 
#$menu_btn.append appendHtml
#$menu_btn.on "click", ->
#	$(this).find('div').toggleClass('tmgt-notification-budge-after')

#silver bullet to cure appending scroll text also append in body of next tab view when  switching tab in index.html
$tab_switcher.on "click", ->
	

# custom scroll bar cb impl
# custom cb when user scroll to top of scrollbar and update status via xhr 
customScrollCb = () -> 	
	if mcs.top == mcs.draggerTop		
		$float_msg.css {'opacity': '1'}
		if show			
			show = false;
		else 
			#xhr impl

customWhileScrollCb = () ->
	if mcs.top != mcs.draggerTop
		$float_msg.css {'opacity': '0'}

#ajax cb TODO: XHR impl to get chat msg from server

#custom scrollbar impl
$custom_scrollbar.mCustomScrollbar({
	scrollButtons:
		enable:true,
	theme:"dark",
	callbacks:
		onScroll: () ->		
			customScrollCb()	
		onTotalScroll: () ->
			console.log ''
		onScrollStart: () ->
			# console.log mcs.top,
		onTotalScrollOffset:40,
		whileScrolling: () ->
			customWhileScrollCb() 						
})

$user_chat_gruoup.mCustomScrollbar({
	scrollButtons:
		enable: true,
	theme: "dark"
	# there is no cb 
})

$('#tmgt-notification ul').mCustomScrollbar({
  scrollButtons:
    enable: true,
  theme: "dark"
})

$('#mCSB_1').mCustomScrollbar({
  scrollButtons:
    enable: true,
  theme: "dark"
})

$notification_container.mCustomScrollbar({
	scrollButtons:
		enable: true,
	theme: "dark"
})

#templating function , this is just utility function 
if String.prototype.partial != 'function'
	String.prototype.partial = (o) ->
		this.replace /{([^{}]*)}/g, (a,b) ->
			r = o[b]
			typeof r == 'string' ? r : a


# newly implement notification 
# inject to the specific area dom node
template1 = '<div class="tmgt-notification-budge">{{cnt}}</div>'
# it will accept the dom element you wanna inject Notification
injectNotificaion = (domElement) ->
	dom = domElement # store the parameter in a function scope variable for accessing late
	data = {cnt: 0} # data used in template
	cnt = 0 # initialise with 0 
	{
		appendToNode: () ->
			dom.append($(template1.partial(data)))

		getNotificationCnt: () ->
			cnt = dom.find('div').html().parseInt()

		incNotificationCnt: () ->
			cnt += 1
			domElement.find('div').html(cnt)

		removeTheNode: () -> #this is not a necessary way
	}

# fire a notification 
fireNotification = (area) ->




# chatGroup parameters accept arrays
chatGroupId = 0;

# new Scrollbar implmentation 
# newly created tab view must be bind with mCustomScrollbar function
createScroller = (chGroup) ->

# definition list template which will set definitin list data for tab view 
	dlTemplate 					= '<dd><a href="#{{panel-url}}">{{panel-name}}</a></dd>'

# this will be display at the top left corner of the chat box that will display user profile pic who are chatting with current user 
	userProfileTemplate 		= '<img src="{{profile-url}}" 
								   class="tip-bottom radius" 
								   alt="" data-tooltip data-options="disable_for_touch:true" 
								   title="{{profile-name}}">'

#this will wrap and hold the user chat msg 
	chatmsgContainerTemplate  	=  '<div class="content {{active}}" id="panel-{{chatGroupdId}}">
										<div class="tmgt-floating-msg">scroll up again to load earlier msg</div>
										<div class="tmgt-chat-box" id="tmgt-chat-custom-scrollbar-{{chatGroupdId}}">

										</div>
									</div>'
	chatMsgDataTemplate 		=  '<div class="chat-container">                    
                                        <div class="{{user-type}}-chat">
                                            <div class="profile-pic">
                                                <em>{{user-name}}</em><br>
                                                <img src="{{profile-url}}" alt="" width="100%">
                                            </div>  <!-- eo user profile pic -->
                                            <div class="msg">
                                                {{msg}}
                                            </div> <!-- eo msg -->
                                        </div> <!-- {{user-type}}-chat -->
                                    </div> <!-- eo container -->'
	groupdId 					= chatGroupId 
	chatGroupId 			   += 1

	{
		appendUserData: () ->
# create a tab group 

# create a chat msg container 

# user profile picture 
		
		updateUserData: () ->
# append newly created chat msg to the chat msg container 
		
		userScorllerImpl: () ->
# if user scroll at the top scroll again to reload older msg will appear
# if user scroll again it will load 
		
		appendMsgData: () ->
# append msg 
		
		loadDataFromDb: () ->
# when user scroll again it will load the former data that is stored in the db 
# control with xhr 
	}
