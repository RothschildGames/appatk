class AppAtk.Views.HUD
  constructor: (@game) ->
    @create()

  create: ->
    for i in [0..4]
      shape = @game.add.graphics(17 + 15*i, 26)
      shape.lineStyle(1, 0xFFFFFF, 1)
      if i < 3
        shape.beginFill(0xFFFFFF, 1)
      shape.drawCircle(0, 0, 11)

    @scoreText = @game.add.text(93, 12, "400 G")
    @scoreText.font = 'Helvetica Neue'
    @scoreText.fontSize = 24
    @scoreText.fontWeight = 200
    @scoreText.fill = '#FFFFFF'

    @titleText = @game.add.text(game.world.centerX, 12, "APPATK")
    @titleText.anchor.setTo(.5, 0)
    @titleText.font = 'Helvetica Neue'
    @titleText.fontSize = 25
    @titleText.fontWeight = 500
    @titleText.fill = '#FFFFFF'

    @healthText = @game.add.text(620, 12, "100%")
    @healthText.font = 'Helvetica Neue'
    @healthText.fontSize = 24
    @healthText.fontWeight = 200
    @healthText.fill = '#FFFFFF'

    battery = @game.add.sprite(738, 17, 'battery')
    battery.anchor.setTo(1, 0)

    @batteryFill = @game.add.graphics(691, 19)
    @batteryFill.beginFill(0xFFFFFF, 1)
    @batteryFill.drawRect(0,0, 40, 14)
