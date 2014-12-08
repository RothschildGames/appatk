class AppAtk.GameOver
  fadeSpeed: 300

  preload: ->
    bg = @add.sprite(0, 0, 'background')
    @add.tween(bg).to({alpha: 0}, @fadeSpeed).start()

    deadBattery = @add.sprite(@world.centerX, @world.centerY, 'dead-battery')
    deadBattery.alpha = 0
    deadBattery.anchor.setTo(.5)
    @add.tween(deadBattery).to({alpha: 1}, @fadeSpeed).start()

    text = @add.text(@world.centerX, @world.centerY - 100, 'Game Over')
    text.anchor.setTo(0.5, 1)
    text.align = 'center'
    text.font = 'Helvetica Neue'
    text.fontSize = 125
    text.fontWeight = 100
    text.fill = '#FFFFFF'

    slideText = @add.text(@world.centerX, 1170, '> click to start')
    slideText.anchor.setTo(0.5, 0.5)
    slideText.alpha = 0
    slideText.font = 'Helvetica Neue'
    slideText.fontSize = 48
    slideText.fontWeight = 200
    slideText.fill = '#FFFFFF'

    slideText.inputEnabled = true
    slideText.events.onInputDown.add =>
      if slideText.alpha > 0
        game.state.start('game')

    setTimeout(
      (=> @add.tween(slideText).to({alpha: 0.8}, 200).start())
      , 1200
    )