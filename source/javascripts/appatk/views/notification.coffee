class AppAtk.Views.Notification extends Phaser.Graphics

  constructor: (@game) ->
    super(game, 0, 0)
    @beginFill(0x000000, 0.8)
    @drawRect(0,0,game.width, 128)
    @beginFill(0xffcc00, 1)
    @drawRoundedRect(30, 15, 40 ,40, 5)
    @beginFill(0x757378, 1)
    @drawRoundedRect((game.width  - 74 )/ 2, 110, 74 ,10, 7)

    game.add.existing(@)

    text = @game.add.text(92, 18, 'AppAtk')
    text.font = 'Helvetica Neue'
    text.fontSize = 27
    text.fontWeight = 500
    text.fill = '#FFFFFF'
    @addChild(text)

    text = @game.add.text(209, 21, 'now')
    text.font = 'Helvetica Neue'
    text.fontSize = 22
    text.fontWeight = 200
    text.fill = '#939290'
    @addChild(text)

    text = @game.add.text(92, 49, 'Next wave in 30s')
    text.font = 'Helvetica Neue'
    text.fontSize = 26
    text.fontWeight = 200
    text.fill = '#FFFFFF'
    @addChild(text)
    @notificationText = text
    @y = -@height

  showNotification: (message= "Next wave in 30s", cb= ->) ->
    @notificationText.text = message
    tween = @game.add.tween(@)
      .to({y: 0}, 500, Phaser.Easing.Quadratic.Out)
      .to({y: -@height}, 200, Phaser.Easing.Quadratic.In, false, 1400)
    tween.onComplete.add(cb)
    tween.start()
