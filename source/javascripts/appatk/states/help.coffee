class AppAtk.Help

  preload: ->
    @gameState = new AppAtk.Models.GameState()
    @hud = new AppAtk.Views.HUD(@, @gameState)

  create: ->
    bg = @add.sprite(0, 0, 'background')

    @hud.create()

    help = @add.sprite(0, 0, 'help')
    help.alpha = 0
    @add.tween(help).to({alpha: 1}, 300).start()
    help.inputEnabled = true
    help.events.onInputDown.add =>
      game.state.start('game')