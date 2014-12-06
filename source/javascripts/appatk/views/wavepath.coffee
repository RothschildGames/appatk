class AppAtk.Views.WavePath extends Phaser.Graphics

  constructor: (game, x, y, @wavePath) ->
    super(game, x, y)

    @lineStyle(15, 0xFFEE00, 0.5)

    firstPos = @_wavePathWorldPos(wavePath[0], 'first')
    @moveTo(firstPos.x, firstPos.y)

    _.times(wavePath.length - 1, (i) =>
      wavePathPos = wavePath[i+1]
      nextWavePos = wavePath[i+2]
      if nextWavePos
        newRowPos = @_wavePathWorldPos(wavePath[i+1])
        @lineTo(newRowPos.x, newRowPos.y)
        sameRowPos = @_wavePathWorldPos(new Phaser.Point(nextWavePos.x, wavePathPos.y))
        @lineTo(sameRowPos.x, sameRowPos.y)
      else
        newRowPos = @_wavePathWorldPos(wavePath[i+1], 'last')
        @lineTo(newRowPos.x, newRowPos.y)
    )

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