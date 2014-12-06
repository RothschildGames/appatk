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

    shape = game.add.graphics(0, 0)
    shape.lineStyle(15, 0xFFEE00, 0.5)

    firstPos = @_wavePathWorldPos(wavePath[0], 'first')
    shape.moveTo(firstPos.x, firstPos.y)

    _.times(wavePath.length - 1, (i) =>
      wavePathPos = wavePath[i+1]
      nextWavePos = wavePath[i+2]
      if nextWavePos
        newRowPos = @_wavePathWorldPos(wavePath[i+1])
        shape.lineTo(newRowPos.x, newRowPos.y)
        sameRowPos = @_wavePathWorldPos(new Phaser.Point(nextWavePos.x, wavePathPos.y))
        shape.lineTo(sameRowPos.x, sameRowPos.y)
      else
        newRowPos = @_wavePathWorldPos(wavePath[i+1], 'last')
        shape.lineTo(newRowPos.x, newRowPos.y)
    )

  update: ->
    # if @sprite.input.pointerOver(game.input.activePointer)
    #   @sprite.scale.x = 1.2
    #   @sprite.scale.y = 1.2
    # else
    #   @sprite.scale.x = 1
    #   @sprite.scale.y = 1

    # if .position.


  _wavePathWorldPos: (pos, specialType = null) ->
    horGutter = 53
    edgeHorGutter = 55
    verGutter = 57.5
    edgeVerGutter = 59
    iconWidth = 120
    iconHeight = 119
    x = (iconWidth * (pos.x + 1)) + edgeHorGutter + (horGutter * (pos.x)) + (horGutter * 0.5)
    y = (iconHeight + verGutter) * (pos.y)
    y += (verGutter * 0.5) if specialType == null
    y += edgeVerGutter + (horGutter * 0.5) if specialType == 'last'

    new Phaser.Point(x, y)

window.game = game
