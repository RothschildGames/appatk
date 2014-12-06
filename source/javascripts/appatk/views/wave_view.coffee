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
      type = if ((i+1) == path.length - 1) then 'last' else null
      nextWorldCoord = AppAtk.Utils.Coords.wavePathWorldPos(path[i+1], type)
      monsterTween = monsterTween.to({x: nextWorldCoord.x, y: nextWorldCoord.y}, 1000)
    )
    monsterTween.start()
