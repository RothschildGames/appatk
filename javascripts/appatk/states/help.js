(function() {
  AppAtk.Help = (function() {
    function Help() {}

    Help.prototype.preload = function() {
      this.gameState = new AppAtk.Models.GameState();
      AppAtk.gameState = this.gameState;
      this.hud = new AppAtk.Views.HUD(this, this.gameState);
      return this.shop = new AppAtk.Views.Shop(game);
    };

    Help.prototype.create = function() {
      var bg, help;
      bg = this.add.sprite(0, 0, 'background');
      this.hud.create();
      this.shop.create();
      help = this.add.sprite(0, 0, 'help');
      help.alpha = 0;
      this.add.tween(help).to({
        alpha: 1
      }, 300).start();
      help.inputEnabled = true;
      return help.events.onInputDown.add((function(_this) {
        return function() {
          return game.state.start('game');
        };
      })(this));
    };

    return Help;

  })();

}).call(this);
