(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  AppAtk.Loader = (function() {
    function Loader() {
      this.startGame = __bind(this.startGame, this);
    }

    Loader.prototype.ready = false;

    Loader.prototype.preload = function() {
      this._createLoadingUI();
      return this._loadGameAssets();
    };

    Loader.prototype._createLoadingUI = function() {
      var bg, slideText, text;
      bg = this.add.sprite(0, 0, 'loading-background');
      text = this.add.text(this.world.centerX, 207, '0%');
      text.anchor.setTo(0.5, 0.5);
      text.align = 'center';
      text.font = 'Helvetica Neue';
      text.fontSize = 175;
      text.fontWeight = 100;
      text.fill = '#FFFFFF';
      slideText = this.add.text(this.world.centerX, 1170, '> click to start');
      slideText.anchor.setTo(0.5, 0.5);
      slideText.alpha = 0;
      slideText.font = 'Helvetica Neue';
      slideText.fontSize = 48;
      slideText.fontWeight = 200;
      slideText.fill = '#FFFFFF';
      bg.inputEnabled = true;
      bg.events.onInputDown.add(this.startGame);
      this.load.onFileComplete.add((function(_this) {
        return function() {
          return text.text = "" + _this.load.progress + "%";
        };
      })(this));
      return this.load.onLoadComplete.add((function(_this) {
        return function() {
          _this.add.tween(slideText).to({
            alpha: 0.8
          }, 200).start();
          return _this.ready = true;
        };
      })(this));
    };

    Loader.prototype.startGame = function() {
      if (this.ready) {
        return this.state.start('help');
      }
    };

    Loader.prototype._loadGameAssets = function() {
      this.load.image('background', 'images/bg.png');
      this.load.image('help', 'images/help.png');
      this.load.image('death-particle', 'images/death-particle.png');
      this.load.spritesheet('monster0', 'images/monster0.png', 42, 33);
      this.load.spritesheet('monster1', 'images/monster1.png', 42, 33);
      this.load.spritesheet('monster2', 'images/monster2.png', 42, 33);
      this.load.spritesheet('monster3', 'images/monster3.png', 42, 33);
      this.load.spritesheet('monster4', 'images/monster4.png', 42, 33);
      this.load.image('battery', 'images/battery.png');
      this.load.image('dead-battery', 'images/dead-battery.png');
      this.load.image('full-battery', 'images/full-battery.png');
      this.load.spritesheet('apps', 'images/apps.png', 120, 119);
      return AppAtk.sfx = new AppAtk.Sfx(this);
    };

    return Loader;

  })();

}).call(this);
