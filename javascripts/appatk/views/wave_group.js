(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Views.WaveGroup = (function(_super) {
    __extends(WaveGroup, _super);

    function WaveGroup(game, x, y) {
      WaveGroup.__super__.constructor.call(this, game, x, y);
      this._generateMask();
      this.on = false;
      this.interval = 0;
      game.add.existing(this);
      AppAtk.on('lost-life', (function(_this) {
        return function() {
          return _this.missed += 1;
        };
      })(this));
      AppAtk.on('monster-killed', (function(_this) {
        return function() {
          return _this.killed += 1;
        };
      })(this));
    }

    WaveGroup.prototype.startWave = function(wave) {
      this.wave = wave;
      this.on = true;
      this.monstersCounter = 0;
      this.killed = 0;
      return this.missed = 0;
    };

    WaveGroup.prototype.createMonsterInWave = function() {
      var monster, path, startCoord;
      this.monstersCounter += 1;
      path = this.wave.get('path');
      startCoord = AppAtk.Utils.Coords.wavePathWorldPos(path[0], 'first');
      monster = new AppAtk.Views.MonsterView(game, startCoord.x, startCoord.y, this.wave.get('monster'));
      game.add.existing(monster);
      this.add(monster);
      return monster.generatePathTween(path);
    };

    WaveGroup.prototype.update = function() {
      var doneCreatingMonsters;
      if (!this.on) {
        return;
      }
      doneCreatingMonsters = this.monstersCounter >= this.wave.get('amount');
      if (doneCreatingMonsters) {
        if (this.countLiving() === 0) {
          AppAtk.trigger('end-wave', this);
          return this.on = false;
        }
      } else {
        this.interval += 1;
        if ((this.interval % this.wave.get('interval')) === 0) {
          return this.createMonsterInWave();
        }
      }
    };

    WaveGroup.prototype._drawWavePath = function(wavePath) {
      var firstPos;
      this.wavePath || (this.wavePath = game.add.graphics(0, 0));
      this.wavePath.clear();
      this.wavePath.lineStyle(15, 0xFFEE00, 0.5);
      firstPos = AppAtk.Utils.Coords.wavePathWorldPos(wavePath[0], 'first');
      this.wavePath.moveTo(firstPos.x, firstPos.y);
      return _.times(wavePath.length - 1, (function(_this) {
        return function(i) {
          var wavePathPos, worldPos;
          wavePathPos = wavePath[i + 1];
          worldPos = AppAtk.Utils.Coords.wavePathWorldPos(new Phaser.Point(wavePathPos.x, wavePathPos.y));
          return _this.wavePath.lineTo(worldPos.x, worldPos.y);
        };
      })(this));
    };

    WaveGroup.prototype._generateMask = function() {
      this.mask = game.add.graphics(0, 0);
      this.mask.beginFill(0xFF3300);
      this.mask.drawRect(0, 18 * 3, 250 * 3, 362 * 3);
      return this.mask.endFill();
    };

    return WaveGroup;

  })(Phaser.Group);

}).call(this);
