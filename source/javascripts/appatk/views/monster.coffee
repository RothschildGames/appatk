class AppAtk.Views.Monster extends Phaser.Sprite

  constructor: (game, x, y) ->
    super(game, x, y, 'monster')
    @anchor.setTo(0.5, 0.5)
    @animations.add('walk', [0, 1, 2, 3, 3, 2, 1, 0, 6, 5, 4, 5, 6], 6, true)
    @animations.play('walk')