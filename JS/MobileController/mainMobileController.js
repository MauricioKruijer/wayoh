(function() {
  var doOnOrientationChange, onCorrectKey, onIncorrectKey, pressTimer, socket;

  window.key = null;

  $((function(_this) {
    return function() {
      console.log('setup controller');
      doOnOrientationChange();
      return window.addEventListener('orientationchange', doOnOrientationChange);
    };
  })(this));

  pressTimer = null;

  socket = io();

  doOnOrientationChange = function() {
    var height, width;
    width = window.innerWidth;
    height = window.innerHeight;
    if (width > height) {
      $('#rotateDevice').addClass('fadeOut');
      return setTimeout(function() {
        return $('#rotateDevice').addClass('hidden');
      }, 500);
    } else {
      $('#rotateDevice').removeClass('hidden');
      return setTimeout(function() {
        return $('#rotateDevice').removeClass('fadeOut');
      }, 50);
    }
  };

  onCorrectKey = function() {
    $("#inputKey").blur();
    $('body, intro').removeClass('intro');
    $('#keypadWrapper').removeClass('hidden');
    $('#introWrapper').addClass('downAndOut');
    return setTimeout(function() {
      return $('#introWrapper').addClass('hidden');
    }, 666);
  };

  onIncorrectKey = function() {
    $('#incorrectKey').removeClass('hidden');
    setTimeout(function() {
      $('#incorrectKey').removeClass('faded');
      return $('#inputKey').val('');
    }, 10);
    return setTimeout(function() {
      $('#incorrectKey').addClass('faded');
      return setTimeout(function() {
        return $('#incorrectKey').addClass('hidden');
      }, 333);
    }, 2200);
  };

  $('#inputForm').on('submit', (function(_this) {
    return function(e) {
      e.stopPropagation();
      e.preventDefault();
      window.key = $('#inputKey').val().toString();
      socket.emit('key-entered', window.key);
      socket.on('correct-key', onCorrectKey);
      return socket.on('incorrect-key', onIncorrectKey);
    };
  })(this));

  $('.button').on('touchstart', (function(_this) {
    return function(event) {
      var button, whichButton;
      $('body').addClass('press');
      clearTimeout(pressTimer);
      pressTimer = setTimeout(function() {
        return $('body').removeClass('press');
      }, 100);
      whichButton = event.currentTarget.id;
      button = whichButton.toString();
      return socket.emit('button-push', button);
    };
  })(this));

}).call(this);
