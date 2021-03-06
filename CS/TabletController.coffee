class window.TabletController
	_timeSinceLastKeyPress: 0
	_autoTimer: null

	constructor: ->
		console.log 'setup tablet controller'
		@_socket = io()

		@generateKey()

	#generate key to enter on mobile device
	generateKey: =>
		window.key = 10000 + Math.floor Math.random()*89999
		window.key = window.key.toString()

		@_socket.emit 'new-desktop-client', window.key

		#safety... callbacks from Socket to check if a key already exists or not. If already exists, generate a new key.
		@_socket.on 'key-accepted', @onKeyAccepted
		@_socket.on 'key-unaccepted', @generateKey


	onKeyAccepted: =>
		$('.key').html window.key
		$('#keyInAbout').removeClass 'hidden'

		@_socket.on 'button-push', (button) =>
			@mapSocketEvents button

		@_socket.on 'key-entered', (key) =>
			if key is window.key
				$('#ipadInstructions').addClass 'downAndOut'
				setTimeout () ->
					$('#ipadInstructions').addClass 'hidden'
				,666
			else
				console.log 'incorrect key'

	#map keycodes from device controller and send events
	mapSocketEvents: (button) =>
		@setAutoTimer()
		window.events.automatic.dispatch 'off'
		switch button
			when "a1" then window.events.frequency.dispatch 1
			when "a2" then window.events.frequency.dispatch 2
			when "a3" then window.events.frequency.dispatch 3
			when "a4" then window.events.frequency.dispatch 4
			when "a5" then window.events.frequency.dispatch 5
			when "a6" then window.events.frequency.dispatch 6
			when "a7" then window.events.frequency.dispatch 7
			when "a8" then window.events.frequency.dispatch 8
			when "a9" then window.events.frequency.dispatch 9
			when "a10" then window.events.inverseCols.dispatch()

			when "b1" then window.events.makeSpecial.dispatch 1
			when "b2" then window.events.makeSpecial.dispatch 2
			when "b3" then window.events.makeSpecial.dispatch 3
			when "b4" then window.events.makeSpecial.dispatch 4
			when "b5" then window.events.makeSpecial.dispatch 5
			when "b6" then window.events.makeSpecial.dispatch 6
			when "b7" then window.events.makeSpecial.dispatch 7
			when "b8" then window.events.makeSpecial.dispatch 8
			when "b9" then window.events.makeSpecial.dispatch 9
			when "b10" then window.events.makeSpecial.dispatch 0
			when "b11" then window.events.makeSpecial.dispatch 11

			when "c1" then window.events.showText.dispatch 'boom'
			when "c2" then window.events.showText.dispatch 'tssk'
			when "c3" then window.events.showText.dispatch 'wobb'
			when "c4" then window.events.showText.dispatch 'clap'
			when "c5" then window.events.showIllustration.dispatch 'heart'
			when "c6" then window.events.showIllustration.dispatch 'hand'
			when "c7" then window.events.showIllustration.dispatch 'mouth'
			when "c8" then window.events.showIllustration.dispatch 'eye'
			when "c9" then window.events.showIllustration.dispatch 'ear'
			when "c10" then window.events.transform.dispatch 'squashX'
			when "c11" then window.events.transform.dispatch 'squashY'

			when "d1" then window.events.angela.dispatch 'angela'
			when "d2" then window.events.angela.dispatch 'obama'
			when "d3" then window.events.angela.dispatch 'queen'
			when "d4" then window.events.angela.dispatch 'charles'
			when "d5" then window.events.bass.dispatch 'big'
			when "d6" then window.events.bass.dispatch 'small'
			when "d7" then window.events.filter.dispatch 'blur'
			when "d8" then window.events.squishy.dispatch()
			when "d9" then window.events.break.dispatch 'short'
			when "d0" then window.events.break.dispatch 'long'


	#turn auto on after some time
	setAutoTimer: () =>
		clearInterval @_autoTimer
		@_timeSinceLastKeyPress = 0

		@_autoTimer = setInterval =>
			@_timeSinceLastKeyPress += 1
			if @_timeSinceLastKeyPress > 10
				clearInterval @_autoTimer
				@_timeSinceLastKeyPress = 0
				window.events.automatic.dispatch 'on'
				console.log 'automatic ON'
		,7000