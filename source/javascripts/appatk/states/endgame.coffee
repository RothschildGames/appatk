class AppAtk.EndGame
  fadeSpeed: 300

  constructor: (gameOver) ->
    if gameOver
      @image = 'dead-battery'
      @text = 'Game Over'
    else
      @image = 'full-battery'
      @text = 'You Won!'


  preload: ->
    bg = @add.sprite(0, 0, 'background')
    @add.tween(bg).to({alpha: 0}, @fadeSpeed).start()

    battery = @add.sprite(@world.centerX, @world.centerY, @image)
    battery.alpha = 0
    battery.anchor.setTo(.5)
    @add.tween(battery).to({alpha: 1}, @fadeSpeed).start()

    text = @add.text(@world.centerX, @world.centerY - 100, @text)
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

    bg.inputEnabled = true
    bg.events.onInputDown.add =>
      if slideText.alpha > 0
        game.state.start('game')

    setTimeout(
      (=> @add.tween(slideText).to({alpha: 0.8}, 200).start())
      , 1200
    )