(function() {
  var game;

  game = new Phaser.Game(250 * 3, 445 * 3, Phaser.CANVAS, 'drawing-canvas', {
    init: function() {
      return game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
    },
    preload: function() {
      game.load.image('background', '/images/bg.png');
      game.load.image('death-particle', '/images/death-particle.png');
      game.load.spritesheet('monster', '/images/monster.png', 42, 33);
      this.sfx = new AppAtk.Sfx(game);
      this.gameState = new AppAtk.Models.GameState();
      this.hud = new AppAtk.Views.HUD(game, this.gameState);
      this.shop = new AppAtk.Views.Shop(game);
      this.waves = AppAtk.Models.waves;
      return AppAtk.gameState = this.gameState;
    },
    create: function() {
      var bg, homeButton, notification;
      bg = game.add.sprite(0, 0, 'background');
      this.sfx.start();
      this.hud.create();
      this.shop.create();
      this.structure = new AppAtk.Models.Structure();
      game.structure = this.structure;
      this.wave = new AppAtk.Views.WaveGroup(game, 0, 0);
      game.wave = this.wave;
      notification = new AppAtk.Views.Notification(game);
      game.notification = notification;
      homeButton = document.getElementById('home-button');
      homeButton.onclick = (function(_this) {
        return function() {
          return _this._nextWave();
        };
      })(this);
      game.notification.showNotification('Next wave in 2 seconds');
      setTimeout(((function(_this) {
        return function() {
          return _this._generateWave();
        };
      })(this)), 2000);
      AppAtk.on('end-wave', (function(_this) {
        return function() {
          return _this._endWave();
        };
      })(this));
      return AppAtk.gameState.on('change:lowHealth', (function(_this) {
        return function() {
          if (AppAtk.gameState.get('lowHealth')) {
            return game.notification.showNotification("Low Battery, be careful!", 600);
          }
        };
      })(this));
    },
    _endWave: function() {
      var message;
      message = this.wave.killed > this.wave.missed ? 'Great job!' : 'Let\'s do better next time.';
      game.notification.showNotification("" + message + " Next wave in 3 seconds");
      return setTimeout(((function(_this) {
        return function() {
          return _this._nextWave();
        };
      })(this)), 3000);
    },
    _nextWave: function() {
      this.gameState.waveUp();
      return this._generateWave();
    },
    _generateWave: function() {
      var wave, wavePath;
      wavePath = this.structure.generateWavePath();
      wave = this.waves.at(this.gameState.get('wave') - 1);
      wave.set('path', wavePath);
      return this.wave.startWave(wave);
    }
  });

  window.game = game;

}).call(this);
