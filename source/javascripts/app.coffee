game = new Phaser.Game 250*3, 445*3, Phaser.CANVAS, 'drawing-canvas',
  init: ->
    game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT

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
    game.structure = @structure
    @waveView = new AppAtk.Views.WaveView(game, 0, 0)
    @_generateWave()

    homeButton = document.getElementById('home-button')
    homeButton.onclick = => @_generateWave()

  update: ->
    @waveView?.update()

  _generateWave: ->
    wavePath = @structure.generateWavePath()
    wave = new AppAtk.Models.Wave(path: wavePath)
    @waveView.startWave(wave)


window.game = game
