game = new Phaser.Game 250*3, 445*3, Phaser.AUTO, 'drawing-canvas',
  init: ->
    game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT

  preload: ->
    game.load.image('background', '/images/bg.png');
    game.load.image('icon-01', '/images/app-atk-icon.png');

  create: ->
    bg = game.add.sprite(0, 0, 'background');
    # bg.scale.x = 0.33
    # bg.scale.y = 0.33

    sprite = game.add.sprite(574, 1170, 'icon-01')
    # sprite.scale.x = 0.33
    # sprite.scale.y = 0.33

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
