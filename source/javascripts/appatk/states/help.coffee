class AppAtk.Help

  preload: ->
    @gameState = new AppAtk.Models.GameState()
    AppAtk.gameState = @gameState
    @hud = new AppAtk.Views.HUD(@, @gameState)
    @shop = new AppAtk.Views.Shop(game)

  create: ->
    bg = @add.sprite(0, 0, 'background')

    @hud.create()
    @shop.create()

    help = @add.sprite(0, 0, 'help')
    help.alpha = 0
    @add.tween(help).to({alpha: 1}, 300).start()
    help.inputEnabled = true
    help.events.onInputDown.add =>
      game.state.start('game')