game = new Phaser.Game 250*3, 445*3, Phaser.CANVAS, 'drawing-canvas',
  init: ->
    game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT
    @locations = []
    for i in [0..4]
      for j in [0..5]
        @locations.push({x: 55+60 + (120+53)*i, y: 59+60 + (120+57)*j })

  preload: ->
    game.load.image('background', '/images/bg.png')
    game.load.image('icon-01', '/images/app-atk-icon.png')
    game.load.image('icon-02', '/images/icon-02.png')
    game.load.image('battery', '/images/battery.png')

  create: ->
    bg = game.add.sprite(0, 0, 'background')

    for i in [0..4]
      shape = game.add.graphics(17 + 15*i, 26)
      shape.lineStyle(1, 0xFFFFFF, 1)
      if i < 3
        shape.beginFill(0xFFFFFF, 1)
      shape.drawCircle(0, 0, 11)

    text = game.add.text(93, 12, "400 G")
    text.font = 'Helvetica Neue'
    text.fontSize = 24
    text.fontWeight = 200
    text.fill = '#FFFFFF'

    text = game.add.text(game.world.centerX, 12, "APPATK")
    text.anchor.setTo(.5, 0)
    text.font = 'Helvetica Neue'
    text.fontSize = 25
    text.fontWeight = 500
    text.fill = '#FFFFFF'
    # window.text = text

    text = game.add.text(620, 12, "100%")
    # text.anchor.setTo(.5, 0)
    text.font = 'Helvetica Neue'
    text.fontSize = 24
    text.fontWeight = 200
    text.fill = '#FFFFFF'
    window.text = text

    battery = game.add.sprite(738, 17, 'battery')
    battery.anchor.setTo(1, 0)
    window.battery = battery

    batteryFill = game.add.graphics(691, 19)
    # batteryFill.anchor.setTo(1, 0)
    batteryFill.beginFill(0xFFFFFF, 1)
    batteryFill.drawRect(0,0, 40, 14)
    # window.battery = battery
    # shape = game.add.graphics(17 + 15*i, 26)
    # shape.lineStyle(1, 0xFFFFFF, 1)
    # if i < 3



    @sprite = game.add.sprite(634, 1230, 'icon-01')
    @sprite.anchor.setTo(.5, .5)
    @sprite.buttonMode = true
    @sprite.inputEnabled = true
    @sprite.events.onInputOut.add =>
      game.add.tween(@sprite.scale).to({x: 1, y: 1}, 200, Phaser.Easing.Linear.None, true)
    @sprite.events.onInputOver.add =>
      game.add.tween(@sprite.scale).to({x: 1.1, y: 1.1}, 200, Phaser.Easing.Linear.None, true)
    # @sprite.events.onInputDown.add =>
      # console.log('click')
    # newTower = game.add.sprite(@sprite.x, @sprite.y, 'icon-02')
    # newTower.anchor.setTo(.5, .5)
    # newTower.inputEnabled = true

    # newTower.input.enableSnap(120, 120, false, true, 55, 59);
    # @sprite.input.startDrag(game.input.activePointer)
    # newTower.events.onDragStart.add =>
      # game.add.tween(newTower.scale).to({x: 1, y: 1}, 50, Phaser.Easing.Linear.None, true)

    @sprite.input.enableDrag(true)
    @sprite.events.onDragStop.add =>
      location = _.min @locations, (loc) =>
        @sprite.position.distance(loc)
      game.add.tween(@sprite).to({x: location.x, y: location.y}, 80, Phaser.Easing.Linear.None, true)

    structure = new AppAtk.Models.Structure()
    wavePath = structure.generateWavePath()

    wavePathView = new AppAtk.Views.WavePath(game, 0, 0)
    wavePathView.drawWavePath(wavePath)
    game.add.existing(wavePathView)

    homeButton = document.getElementById('home-button')
    homeButton.onclick = =>
      wavePath = structure.generateWavePath()
      wavePathView.drawWavePath(wavePath)

  update: ->


window.game = game
