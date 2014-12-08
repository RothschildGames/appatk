class AppAtk.Views.MonsterView extends Phaser.Sprite

  SPEED_SLOW_MULTIPLIER = 8
  BASE_ROTATION_SPEED = 70

  SLOWDOWN_RATIO = 0.8
  SLOWDOWN_COOLDOWN = 1200 #ms

  HIT_SPEED = 100
  HIT_SCALE = 0.7

  constructor: (game, x, y, @monster) ->
    super(game, x, y, @monster.get('image'))
    @health = @monster.get('hp')
    @anchor.setTo(0.5, 0.5)
    @animations.add('walk', [0, 1, 2, 3, 3, 2, 1, 0, 6, 5, 4, 5, 6], 6, true)
    @animations.play('walk')
    @scale = new Phaser.Point(@monster.get('scale'), @monster.get('scale'))
    @events.onKilled.add(=> @_onKilled())

  generatePathTween: (@path) ->
    @monsterTween = game.add.tween(@)
    lastIndex = path.length - 1
    lastPoint = null
    for point, i in path
      isLast = (i == path.length - 1)
      worldPoint = AppAtk.Utils.Coords.wavePathWorldPos(point, if isLast then 'last' else null)
      if lastWorldPoint
        distance = Phaser.Point.distance(worldPoint, lastWorldPoint)
        if worldPoint.x == lastWorldPoint.x
          angle = 0
        else if worldPoint.x > lastWorldPoint.x
          angle = -90
        else
          angle = 90
        @monsterTween.to({angle: angle}, BASE_ROTATION_SPEED / @monster.get('speed'))
        @monsterTween.to({x: worldPoint.x, y: worldPoint.y}, distance / @monster.get('speed') * SPEED_SLOW_MULTIPLIER)

      lastWorldPoint = worldPoint

    @monsterTween.onComplete.add(=>
      AppAtk.trigger('lost-life', @monster.get('damage'))
      @destroy()
    )
    @monsterTween.start()

  _onKilled: ->
    @monsterTween.stop()
    AppAtk.trigger('monster-killed', @monster.get('loot'))

    emitter = new AppAtk.Views.MonsterParticles(game, @x, @y, @monster.get('tint'))
    game.add.existing(emitter)

  damage: ->
    super
    AppAtk.trigger('monster-hit') if @health > 0
    game.add.tween(@scale).to({x: HIT_SCALE, y: HIT_SCALE}, HIT_SPEED, Phaser.Easing.Sinusoidal.InOut).to({x: 1, y: 1}, HIT_SPEED, Phaser.Easing.Sinusoidal.InOut).start()
    emitter = new AppAtk.Views.MonsterParticles(game, @x, @y, @monster.get('tint'), 15, 250)
    game.add.existing(emitter)

  slowdown: ->
    @monsterTween.timeScale *= SLOWDOWN_RATIO
    @tint = 0xFFFFFF
    setTimeout(
      (=>
        @monsterTween.timeScale /= SLOWDOWN_RATIO
        @tint = @monster.get('tint')
      ), SLOWDOWN_COOLDOWN
    )
