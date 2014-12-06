class AppAtk.Views.WaveView extends Phaser.Sprite

  constructor: (game, x, y) ->
    super(game, x, y)
    @wavePathView = new AppAtk.Views.WavePath(game, 0, 0)
    game.add.existing(@wavePathView)

  startWave: (@wave) ->
    path = @wave.get('path')
#    @wavePathView.drawWavePath(path) # FOR DEBUG PURPOSE
    @createMonsterTweenInPath(path)

  createMonsterTweenInPath: (path) ->
    startCoord = AppAtk.Utils.Coords.wavePathWorldPos(path[0], 'first')
    monster = new AppAtk.Views.Monster(game, startCoord.x, startCoord.y)
    game.add.existing(monster)

    monsterTween = game.add.tween(monster)

    _.times(path.length - 1, (i) ->
      nextPathCoord = path[1]
      isLast = ((i+1) == path.length - 1)
      type = if isLast then 'last' else null
      nextWorldCoord = AppAtk.Utils.Coords.wavePathWorldPos(path[i+1], type)
      x = nextWorldCoord.x
      y = nextWorldCoord.y
      y += 15 if isLast
      monsterTween = monsterTween.to({x: x, y: y}, 1000)
    )
    monsterTween.start()
