(function() {
  var game;

  game = new Phaser.Game(250 * 3, 445 * 3, Phaser.CANVAS, 'drawing-canvas');

  game.state.add('boot', new AppAtk.Boot());

  game.state.add('loader', new AppAtk.Loader());

  game.state.add('game', new AppAtk.Game());

  game.state.start('boot');

  window.game = game;

}).call(this);
