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
      worldPos = AppAtk.Utils.Coords.wavePathWorldPos(new Phaser.Point(wavePathPos.x, wavePathPos.y))
      @lineTo(worldPos.x, worldPos.y)
    )
