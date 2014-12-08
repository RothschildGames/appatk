(function() {
  AppAtk.Sfx = (function() {
    Sfx.prototype.music = ['sfx/RinbackTone.ogg', 'sfx/RinbackTone.mp3', 'sfx/RinbackTone.m4a'];

    Sfx.prototype.soundsSources = {
      hit: ['Jump8', 'Jump15', 'Jump17'],
      killMonster: ['Pickup_Coin31', 'Pickup_Coin34', 'Pickup_Coin39', 'Pickup_Coin40', 'Pickup_Coin43'],
      loseHealth: ['Hit_Hurt15', 'Hit_Hurt16', 'Hit_Hurt17', 'Hit_Hurt20', 'Hit_Hurt28']
    };

    Sfx.prototype.sounds = {};

    function Sfx(game) {
      var file, idx, key, soundKey, soundObjects, values, _i, _len, _ref;
      this.game = game;
      _ref = this.soundsSources;
      for (key in _ref) {
        values = _ref[key];
        soundObjects = [];
        for (idx = _i = 0, _len = values.length; _i < _len; idx = ++_i) {
          file = values[idx];
          soundKey = "" + key + idx;
          game.load.audio(soundKey, "sfx/" + file + ".wav");
          soundObjects.push(soundKey);
        }
        this.sounds[key] = soundObjects;
      }
      game.load.audio('bgmusic', this.music);
    }

    Sfx.prototype.start = function() {
      AppAtk.on('monster-killed', (function(_this) {
        return function(monster) {
          return _this.play('killMonster');
        };
      })(this));
      AppAtk.on('lost-life', (function(_this) {
        return function() {
          return _this.play('loseHealth');
        };
      })(this));
      return this.game.add.audio('bgmusic', 0.25, true).play();
    };

    Sfx.prototype.play = function(key) {
      var soundKey;
      soundKey = _.sample(this.sounds[key]);
      return this.game.add.audio(soundKey).play();
    };

    return Sfx;

  })();

}).call(this);
