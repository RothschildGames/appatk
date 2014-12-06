game = new Phaser.Game 250*3, 445*3, Phaser.CANVAS, 'drawing-canvas',
  init: ->
    game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT
    @locations = []
    for i in [0..4]
      for j in [0..5]
        @locations.push({x: 55+60 + (120+53)*i, y: 59+60 + (120+57)*j })

  preload: ->
    game.load.image('background', '/images/bg.png')
    @gameState = new AppAtk.Models.GameState()
    @hud = new AppAtk.Views.HUD(game, @gameState)
    @shop = new AppAtk.Views.Shop(game)

  create: ->
    bg = game.add.sprite(0, 0, 'background')

    @hud.create()
    @shop.create()

    structure = new AppAtk.Models.Structure()
    wavePath = structure.generateWavePath()

    wavePathView = new AppAtk.Views.WavePath(game, 0, 0)
    wavePathView.drawWavePath(wavePath)
    game.add.existing(wavePathView)

    homeButton = document.getElementById('home-button')
    homeButton.onclick = =>
      wavePath = structure.generateWavePath()
      wavePathView.drawWavePath(wavePath)

  update: ->


window.game = game
