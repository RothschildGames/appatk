game = new Phaser.Game 250*3, 445*3, Phaser.WEBGL, 'drawing-canvas',
  init: ->
    game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT

  preload: ->
    game.load.image('background', '/images/bg.png');
    game.load.image('icon-01', '/images/app-atk-icon.png');

  create: ->
    bg = game.add.sprite(0, 0, 'background');
    # bg.scale.x = 0.33
    # bg.scale.y = 0.33

    sprite = game.add.sprite(574, 1170, 'icon-01')
    # sprite.scale.x = 0.33
    # sprite.scale.y = 0.33

    structure = new AppAtk.Models.Structure()
    wavePath = structure.generateWavePath()

    shape = game.add.graphics(0, 0)
    shape.lineStyle(15, 0xFFEE00, 0.5)
    shape.moveTo(30, 30)
    shape.lineTo(100, 120)

  update: ->

window.game = game
