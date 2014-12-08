(function() {
  AppAtk.Loader = (function() {
    function Loader() {}

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
      slideText.inputEnabled = true;
      slideText.events.onInputDown.add((function(_this) {
        return function() {
          if (slideText.alpha > 0) {
            return game.state.start('game');
          }
        };
      })(this));
      this.load.onFileComplete.add((function(_this) {
        return function() {
          return text.text = "" + _this.load.progress + "%";
        };
      })(this));
      return this.load.onLoadComplete.add((function(_this) {
        return function() {
          return _this.add.tween(slideText).to({
            alpha: 0.8
          }, 200).start();
        };
      })(this));
    };

    Loader.prototype._loadGameAssets = function() {
      this.load.image('background', 'images/bg.png');
      this.load.image('death-particle', 'images/death-particle.png');
      this.load.spritesheet('monster', 'images/monster.png', 42, 33);
      this.load.image('battery', 'images/battery.png');
      this.load.spritesheet('apps', 'images/apps.png', 120, 119);
      return AppAtk.sfx = new AppAtk.Sfx(this);
    };

    return Loader;

  })();

}).call(this);
