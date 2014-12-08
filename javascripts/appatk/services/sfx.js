(function() {
  AppAtk.Sfx = (function() {
    Sfx.prototype.music = ['sfx/RinbackTone.ogg', 'sfx/RinbackTone.mp3', 'sfx/RinbackTone.m4a'];

    Sfx.prototype.soundsSources = {
      killMonster: ['coin-01', 'coin-02', 'coin-03', 'coin-04'],
      damageMonster: ['monster-hit-1', 'monster-hit-2', 'monster-hit-3'],
      loseHealth: ['lose-1', 'lose-2', 'lose-3'],
      install: ['install-01'],
      Splashy: ['splashy'],
      Shooty: ['shooty'],
      Slowey: ['slowy'],
      Snipey: ['snipey']
    };

    Sfx.prototype.sounds = {};

    function Sfx(game) {
      var file, idx, key, soundKey, soundObjects, values, _i, _len, _ref;
      this.game = game;
      this.playingMusic = false;
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
      AppAtk.on('monster-hit', (function(_this) {
        return function(monster) {
          return _this.play('damageMonster');
        };
      })(this));
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
      AppAtk.on('installed-tower', (function(_this) {
        return function() {
          return _this.play('install');
        };
      })(this));
      AppAtk.on('tower-fired', (function(_this) {
        return function(tower) {
          return _this.play(tower.get('name'));
        };
      })(this));
    }

    Sfx.prototype.start = function() {
      if (!this.playingMusic) {
        this.game.add.audio('bgmusic', 0.25, true).play();
      }
      return this.playingMusic = true;
    };

    Sfx.prototype.play = function(key) {
      var soundKey;
      soundKey = _.sample(this.sounds[key]);
      return this.game.add.audio(soundKey).play();
    };

    return Sfx;

  })();

}).call(this);
