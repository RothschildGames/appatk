class AppAtk.Views.WaveView extends Phaser.Sprite

  constructor: (game, x, y) ->
    super(game, x, y)
    @wavePathView = new AppAtk.Views.WavePath(game, 0, 0)
    game.add.existing(@wavePathView)

    @mask = game.add.graphics(0, 0)
    @mask.beginFill(0xFF3300)
    @mask.drawRect(0, 18*3, 250*3, 362*3)
    @mask.endFill()

  startWave: (@wave) ->
    path = @wave.get('path')
#    @wavePathView.drawWavePath(path) # FOR DEBUG PURPOSE
    @createMonsterTweenInPath(path)

  createMonsterTweenInPath: (path) ->
    startCoord = AppAtk.Utils.Coords.wavePathWorldPos(path[0], 'first')
    monster = new AppAtk.Views.Monster(game, startCoord.x, startCoord.y)
    game.add.existing(monster)

    monster.generatePathTween(path)
    monster.mask = @mask