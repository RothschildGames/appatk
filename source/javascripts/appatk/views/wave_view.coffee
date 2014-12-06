class AppAtk.Views.WaveView extends Phaser.Sprite

  constructor: (game, x, y) ->
    super(game, x, y)
    @wavePathView = new AppAtk.Views.WavePath(game, 0, 0)
    game.add.existing(@wavePathView)

    @mask = game.add.graphics(0, 0)
    @mask.beginFill(0xFF3300)
    @mask.drawRect(0, 18*3, 250*3, 362*3)
    @mask.endFill()

    @on = false
    @interval = 0

  startWave: (@wave) ->
    @on = true
#    @wavePathView.drawWavePath(@wave.get('path')) # FOR DEBUG PURPOSE

  createMonsterInWave: ->
    path = @wave.get('path')
    startCoord = AppAtk.Utils.Coords.wavePathWorldPos(path[0], 'first')
    monster = new AppAtk.Views.Monster(game, startCoord.x, startCoord.y)
    game.add.existing(monster)

    monster.generatePathTween(path)
    monster.mask = @mask

  update: ->
    return unless @on
    @interval += 1
    @createMonsterInWave() if (@interval % @wave.get('interval')) == 0