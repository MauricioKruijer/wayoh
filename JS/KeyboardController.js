(function() {
  var KeyboardController,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  $((function(_this) {
    return function() {
      return window.audioAnalysisEngine = new KeyboardController();
    };
  })(this));

  KeyboardController = (function() {
    KeyboardController.prototype._bpmCalcArray = [];

    KeyboardController.prototype._dropJumpBPMSensitivity = 50;

    function KeyboardController() {
      this.getBPM = __bind(this.getBPM, this);
      this.keydown = __bind(this.keydown, this);
      console.log('setup keyboard controller');
      window.onkeydown = this.keydown;
    }

    KeyboardController.prototype.keydown = function(e) {
      console.log(e.keyCode);
      if (e.keyCode === !91 || e.keyCode === !82) {
        e.preventDefault();
      }
      switch (e.keyCode) {
        case 48:
          return window.events.inverseCols.dispatch();
        case 49:
          return window.events.frequency.dispatch(1);
        case 50:
          return window.events.frequency.dispatch(2);
        case 51:
          return window.events.frequency.dispatch(3);
        case 52:
          return window.events.frequency.dispatch(4);
        case 53:
          return window.events.frequency.dispatch(5);
        case 54:
          return window.events.frequency.dispatch(6);
        case 55:
          return window.events.frequency.dispatch(7);
        case 56:
          return window.events.frequency.dispatch(8);
        case 57:
          return window.events.frequency.dispatch(9);
        case 32:
          return this.getBPM();
        case 78:
          return window.events.bass.dispatch('small');
        case 66:
          return window.events.bass.dispatch('big');
        case 90:
          return window.events["break"].dispatch('short');
        case 88:
          return window.events["break"].dispatch('long');
        case 38:
          return window.events.peak.dispatch('hi');
        case 40:
          return window.events.peak.dispatch('lo');
        case 37:
          return window.events.peak.dispatch('soft');
        case 39:
          return window.events.peak.dispatch('hard');
        case 81:
          return window.events.makeSpecial.dispatch(1);
        case 87:
          return window.events.makeSpecial.dispatch(2);
        case 69:
          return window.events.makeSpecial.dispatch(3);
        case 82:
          return window.events.makeSpecial.dispatch(4);
        case 84:
          return window.events.makeSpecial.dispatch(5);
        case 89:
          return window.events.makeSpecial.dispatch(6);
        case 85:
          return window.events.makeSpecial.dispatch(7);
        case 73:
          return window.events.makeSpecial.dispatch(8);
        case 79:
          return window.events.makeSpecial.dispatch(9);
        case 80:
          return window.events.makeSpecial.dispatch(0);
        case 65:
          return window.events.showText.dispatch('ber');
        case 83:
          return window.events.showText.dispatch('lin');
        case 68:
          return window.events.showText.dispatch('bisque');
        case 70:
          return window.events.showText.dispatch('rage');
        case 77:
          return window.events.filter.dispatch('blur');
        case 67:
          return window.events.filter.dispatch('invert');
      }
    };

    KeyboardController.prototype.getBPM = function() {
      var time, timeForTenPeaks;
      console.log('bpm');
      time = new Date().getTime();
      if (this._bpmCalcArray.length > 0) {
        if (time - this._bpmCalcArray[this._bpmCalcArray.length - 1] > 2000) {
          this._bpmCalcArray = [];
          console.log('restet bpm calc array');
        }
      }
      this._bpmCalcArray.push(time);
      if (this._bpmCalcArray.length === 10) {
        timeForTenPeaks = this._bpmCalcArray[this._bpmCalcArray.length - 1] - this._bpmCalcArray[0];
        this._bpmCalcArray = [];
        this._approxBPM = Math.floor((60000 / timeForTenPeaks) * 10);
        window.events.BPM.dispatch(this._approxBPM);
        console.log('new bpm is', this._approxBPM);
      }
      if (!this._lastBPM) {
        return this._lastBPM = this._approxBPM;
      } else {
        if (this._approxBPM > this._lastBPM + this._dropJumpBPMSensitivity) {
          window.events.BPMJump.dispatch(this._approxBPM);
        } else if (this._approxBPM < this._lastBPM - this._dropJumpBPMSensitivity) {
          window.events.BPMDrop.dispatch(this._approxBPM);
        }
        return this._lastBPM = this._approxBPM;
      }
    };

    return KeyboardController;

  })();

}).call(this);