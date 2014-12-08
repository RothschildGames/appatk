class AppAtk.Game

  preload: ->
    @gameState = new AppAtk.Models.GameState()
    @shop = new AppAtk.Views.Shop(game)
    @waves = AppAtk.Models.waves
    @hud = new AppAtk.Views.HUD(@, @gameState)
    AppAtk.gameState = @gameState

  create: ->
    bg = game.add.sprite(0, 0, 'background')

    AppAtk.sfx.start()

    @hud.create()
    @shop.create()

    @structure = new AppAtk.Models.Structure()
    game.structure = @structure
    @wave = new AppAtk.Views.WaveGroup(game, 0, 0)
    game.wave = @wave


    notification = new AppAtk.Views.Notification(game)
    game.notification = notification

    homeButton = document.getElementById('home-button')
    homeButton?.onclick = => @_nextWave()

    game.notification.showNotification('Next wave in 2 seconds')
    setTimeout(( => @_generateWave()), 2000)

    AppAtk.on('end-wave', => @_endWave())

    AppAtk.gameState.on('change:lowHealth', =>
      if AppAtk.gameState.get('lowHealth')
        game.notification.showNotification("Low Battery, be careful!", 600)
    )
    AppAtk.gameState.on('change:gameOver', =>
      AppAtk.trigger('game-over')
      game.state.start('gameOver')
    )

  _endWave: ->
    if @gameState.get('wave') == 5
      game.state.start('victory')
    else
      message = if @wave.killed > @wave.missed then 'Great job!' else 'Let\'s do better next time.'
      game.notification.showNotification("#{message} Next wave in 3 seconds")
      setTimeout(( => @_nextWave()), 3000)

  _nextWave: ->
    @gameState.waveUp()
    @_generateWave()

  _generateWave: ->
    wavePath = @structure.generateWavePath()
    wave = @waves.at(@gameState.get('wave') - 1)
    wave.set('path', wavePath)
    @wave.startWave(wave)