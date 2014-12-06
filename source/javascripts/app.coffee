game = new Phaser.Game 250*3, 445*3, Phaser.CANVAS, 'drawing-canvas',
  init: ->
    game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT

  preload: ->
    game.load.image('background', '/images/bg.png');
    game.load.image('icon-01', '/images/app-atk-icon.png');

  create: ->
    bg = game.add.sprite(0, 0, 'background');
    sprite = game.add.sprite(574, 1170, 'icon-01')

    structure = new AppAtk.Models.Structure()
    wavePath = structure.generateWavePath()

    wavePathView = new AppAtk.Views.WavePath(game, 0, 0, wavePath)
    game.add.existing(wavePathView)

  update: ->

window.game = game
