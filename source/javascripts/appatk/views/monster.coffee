class AppAtk.Views.Monster extends Phaser.Sprite

  constructor: (game, x, y) ->
    super(game, x, y, 'monster')
    @anchor.setTo(0.5, 0.5)
    @animations.add('walk', [0, 1, 2, 3, 3, 2, 1, 0, 6, 5, 4, 5, 6], 6, true)
    @animations.play('walk')

  generatePathTween: (path) ->
    monsterTween = game.add.tween(@)
    lastIndex = path.length - 1

    _.times(path.length - 1, (i) ->
      trueIndex = i+1
      nextPathCoord = path[trueIndex]
      isLast = (trueIndex == lastIndex)
      type = if isLast then 'last' else null
      nextWorldCoord = AppAtk.Utils.Coords.wavePathWorldPos(nextPathCoord, type)
      x = nextWorldCoord.x
      y = nextWorldCoord.y
      y += 15 if isLast
      monsterTween = monsterTween.to({x: x, y: y}, 1000)
    )

    monsterTween.start()