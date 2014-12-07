class AppAtk.Views.WaveGroup extends Phaser.Group

  constructor: (game, x, y) ->
    super(game, x, y)
    @_generateMask()
    @on = false
    @interval = 0
    game.add.existing(@)

  startWave: (@wave) ->
    @on = true
    @monstersCounter = 0
#    @_drawWavePath(@wave.get('path')) # Uncomment for debugging.

  createMonsterInWave: ->
    @monstersCounter += 1
    path = @wave.get('path')
    startCoord = AppAtk.Utils.Coords.wavePathWorldPos(path[0], 'first')
    monster = new AppAtk.Views.MonsterView(game, startCoord.x, startCoord.y, @wave.get('monster'))
    game.add.existing(monster)
    @add(monster)

    monster.generatePathTween(path)
    monster.mask = @mask

  update: ->
    return if !@on || @monstersCounter >= @wave.get('amount')
    @interval += 1
    @createMonsterInWave() if (@interval % @wave.get('interval')) == 0

  _drawWavePath: (wavePath) ->
    @wavePath ||= game.add.graphics(0, 0)
    @wavePath.clear()
    @wavePath.lineStyle(15, 0xFFEE00, 0.5)

    firstPos = AppAtk.Utils.Coords.wavePathWorldPos(wavePath[0], 'first')
    @wavePath.moveTo(firstPos.x, firstPos.y)

    _.times(wavePath.length - 1, (i) =>
      wavePathPos = wavePath[i+1]
      worldPos = AppAtk.Utils.Coords.wavePathWorldPos(new Phaser.Point(wavePathPos.x, wavePathPos.y))
      @wavePath.lineTo(worldPos.x, worldPos.y)
    )

  _generateMask: ->
    @mask = game.add.graphics(0, 0)
    @mask.beginFill(0xFF3300)
    @mask.drawRect(0, 18*3, 250*3, 362*3)
    @mask.endFill()

