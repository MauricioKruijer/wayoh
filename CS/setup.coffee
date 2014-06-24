window.stripe = null
window.box = null
is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;


clickContinue = () ->
	$('.choice').addClass 'downAndOut'
	$('.accept').removeClass 'hidden'


	clearInterval window.box	

	setTimeout () ->
		$('#keyboardOrIpad').addClass 'hidden'
		window.events.makeSpecial.dispatch 3
		window.stripe = setInterval () ->
			window.events.makeSpecial.dispatch 3
		,2000
	,1000


	navigator.webkitGetUserMedia
			audio: true
		,setupMic, onError

setupMic = (stream) ->
	$('.accept').addClass 'hidden'
	$('#about').removeClass 'solidBackground'
	clearInterval window.stripe
	setTimeout () ->
		$('#instructions').addClass 'hidden'
	, 500

	window.events.micAccepted.dispatch stream;

onError = (err) ->
	console.log 'error setting up mic'


connectIpad = () ->
	$('#ipadInstructions').removeClass 'hidden'
	
	setTimeout () ->
		$('#ipadInstructions').removeClass 'upAndAway'
	,666

	# console.log 'conect ipad'
	window.key = 10000 + Math.floor Math.random()*89999
	window.key = window.key.toString()
	# console.log 'the key for this is ' + window.key
	$('.key').html window.key
	$('#keyInAbout').removeClass 'hidden'

	window.tabletController = new window.TabletController()

showAbout = () ->
	$('#about').toggleClass 'upAndAway'
	$('#ipadInstructions').toggleClass 'faded'
	

$('.continue').on 'touchstart click', clickContinue
$('#tablet').on 'touchstart click', connectIpad
$('.showAbout').on 'touchstart click', showAbout
$('#makeFullScreen').on 'touchstart click', () ->
	console.log 'requestFullscreen'
	document.getElementById('fullscreen').webkitRequestFullscreen()
	$('#makeFullScreen').addClass 'hidden'


$ =>
	
	setTimeout () ->
		$('#music').removeClass 'hidden'
		window.events.makeSpecial.dispatch 9
		window.events.makeSpecial.dispatch 11
	,500

	setTimeout () ->
		$('#visuals').removeClass 'hidden'
		window.events.makeSpecial.dispatch 9
		window.events.makeSpecial.dispatch 11
	,1250

	setTimeout () ->
		$('#play').removeClass 'hidden'
		window.events.makeSpecial.dispatch 9
		window.events.makeSpecial.dispatch 11
	,2000

	setTimeout () ->
		$('.instruction').addClass 'hidden'
		$('#keyboardOrIpad').removeClass 'hidden'
	,4000

	setTimeout () ->
		$('#instructions').addClass 'hidden'
		$('.choice').removeClass 'upAndAway'
		window.box = setInterval () ->
			window.events.makeSpecial.dispatch 11
		,2000
	,4800

	if is_chrome
		$('#browserNotSupported').addClass 'hidden'