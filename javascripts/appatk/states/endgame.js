(function() {
  AppAtk.EndGame = (function() {
    EndGame.prototype.fadeSpeed = 300;

    function EndGame(gameOver) {
      if (gameOver) {
        this.image = 'dead-battery';
        this.text = 'Game Over';
      } else {
        this.image = 'full-battery';
        this.text = 'You Won!';
      }
    }

    EndGame.prototype.preload = function() {
      var battery, bg, slideText, text;
      bg = this.add.sprite(0, 0, 'background');
      this.add.tween(bg).to({
        alpha: 0
      }, this.fadeSpeed).start();
      battery = this.add.sprite(this.world.centerX, this.world.centerY, this.image);
      battery.alpha = 0;
      battery.anchor.setTo(.5);
      this.add.tween(battery).to({
        alpha: 1
      }, this.fadeSpeed).start();
      text = this.add.text(this.world.centerX, this.world.centerY - 100, this.text);
      text.anchor.setTo(0.5, 1);
      text.align = 'center';
      text.font = 'Helvetica Neue';
      text.fontSize = 125;
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
      bg.events.onInputDown.add((function(_this) {
        return function() {
          if (slideText.alpha > 0) {
            return game.state.start('game');
          }
        };
      })(this));
      return setTimeout(((function(_this) {
        return function() {
          return _this.add.tween(slideText).to({
            alpha: 0.8
          }, 200).start();
        };
      })(this)), 1200);
    };

    return EndGame;

  })();

}).call(this);
