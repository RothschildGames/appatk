game = new Phaser.Game 250*3, 445*3, Phaser.CANVAS, 'drawing-canvas',
  init: ->
    game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT
    @locations = []
    for i in [0..4]
      for j in [0..5]
        @locations.push({x: 55+60 + (120+53)*i, y: 59+60 + (120+57)*j })

  preload: ->
    game.load.image('background', '/images/bg.png')
    game.load.spritesheet('monster', '/images/monster.png', 42, 33)
    @gameState = new AppAtk.Models.GameState()
    @hud = new AppAtk.Views.HUD(game, @gameState)
    @shop = new AppAtk.Views.Shop(game)

  create: ->
    bg = game.add.sprite(0, 0, 'background')

    @hud.create()
    @shop.create()

    @structure = new AppAtk.Models.Structure()
    @waveView = new AppAtk.Views.WaveView(game, 0, 0)
    @_generateWave()

#    monster = new AppAtk.Views.Monster(game, 40, 40)
#    game.add.existing(monster)

    homeButton = document.getElementById('home-button')
    homeButton.onclick = => @_generateWave()

  update: ->

  _generateWave: ->
    wavePath = @structure.generateWavePath()
    wave = new AppAtk.Models.Wave(path: wavePath)
    @waveView.drawWave(wave)



window.game = game
