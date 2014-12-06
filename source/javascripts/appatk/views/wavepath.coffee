class AppAtk.Views.WavePath extends Phaser.Graphics

  constructor: (game, x, y) ->
    super(game, x, y)

  drawWavePath: (@wavePath) ->
    @clear()
    @lineStyle(15, 0xFFEE00, 0.5)

    firstPos = AppAtk.Utils.Coords.wavePathWorldPos(wavePath[0], 'first')
    @moveTo(firstPos.x, firstPos.y)

    _.times(wavePath.length - 1, (i) =>
      wavePathPos = wavePath[i+1]
      nextWavePos = wavePath[i+2]
      if nextWavePos
        newRowPos = AppAtk.Utils.Coords.wavePathWorldPos(wavePath[i+1])
        @lineTo(newRowPos.x, newRowPos.y)
        sameRowPos = AppAtk.Utils.Coords.wavePathWorldPos(new Phaser.Point(nextWavePos.x, wavePathPos.y))
        @lineTo(sameRowPos.x, sameRowPos.y)
      else
        newRowPos = AppAtk.Utils.Coords.wavePathWorldPos(wavePath[i+1], 'last')
        @lineTo(newRowPos.x, newRowPos.y)
    )
