class AppAtk.Views.Monster extends Phaser.Sprite

  constructor: (game, x, y) ->
    super(game, x, y, 'monster')
    @anchor.setTo(0.5, 0.5)
    @animations.add('walk', [0, 1, 2, 3, 3, 2, 1, 0, 6, 5, 4, 5, 6], 6, true)
    @animations.play('walk')

  generatePathTween: (path) ->
    monsterTween = game.add.tween(@)
    lastIndex = path.length - 1
    lastPoint = null
    for point, i in path
      isLast = (i == path.length - 1)
      worldPoint = AppAtk.Utils.Coords.wavePathWorldPos(point, if isLast then 'last' else null)
      if lastWorldPoint
        distance = Phaser.Point.distance(worldPoint, lastWorldPoint)
        monsterTween.to({x: worldPoint.x, y: worldPoint.y}, distance * 10)
      lastWorldPoint = worldPoint

    monsterTween.start()
