game = new Phaser.Game 250*3, 445*3, Phaser.CANVAS, 'drawing-canvas',
  init: ->
    game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT

  preload: ->
    game.load.image('background', '/images/bg.png')
    game.load.image('death-particle', '/images/death-particle.png')
    game.load.spritesheet('monster', '/images/monster.png', 42, 33)
    @sfx = new AppAtk.Sfx(game)

    @gameState = new AppAtk.Models.GameState()
    @hud = new AppAtk.Views.HUD(game, @gameState)
    @shop = new AppAtk.Views.Shop(game)

    @waves = AppAtk.Models.waves

  create: ->
    bg = game.add.sprite(0, 0, 'background')


    @sfx.start()

    @hud.create()
    @shop.create()

    @structure = new AppAtk.Models.Structure()
    game.structure = @structure
    @wave = new AppAtk.Views.WaveGroup(game, 0, 0)
    game.wave = @wave


    notification = new AppAtk.Views.Notification(game)
    game.notification = notification
#    notification.showNotification(')


    homeButton = document.getElementById('home-button')
    homeButton.onclick = => @_nextWave()

    game.notification.showNotification()
    setTimeout(( => @_generateWave()), 500)

  _nextWave: ->
    @gameState.waveUp()
    @_generateWave()

  _generateWave: ->
    wavePath = @structure.generateWavePath()
    wave = @waves.at(@gameState.get('wave') - 1)
    wave.set('path', wavePath)
    @wave.startWave(wave)

window.game = game
