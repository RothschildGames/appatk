(function() {
  var game;

  game = new Phaser.Game(250 * 3, 445 * 3, Phaser.CANVAS, 'drawing-canvas');

  game.state.add('boot', new AppAtk.Boot());

  game.state.add('loader', new AppAtk.Loader());

  game.state.add('help', new AppAtk.Help());

  game.state.add('game', new AppAtk.Game());

  game.state.add('gameOver', new AppAtk.EndGame(true));

  game.state.add('victory', new AppAtk.EndGame(false));

  game.state.start('boot');

  window.game = game;

}).call(this);
