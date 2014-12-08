class AppAtk.Views.Bullet extends Phaser.Graphics

  speed: 150
  SPLASH_RANGE = 150

  constructor: (game, @tower) ->
    super(game, @tower.x, @tower.y)
    @beginFill(@color(), 1)
    @drawCircle(0,0,12)
    game.add.existing(@)

  shootAt: (@target, cb = ->) ->
    game.add.tween(@).to({x: @target.x, y:@target.y}, @speed, Phaser.Easing.Linear.None, true).onComplete.add =>
      @hit()
      @destroy()

  hit: ->
    damage = @tower.model.get('damage')
    @target.damage(@tower.model.get('damage'))
    switch @tower.model.get('spriteIdx')
      when 2 then @target.slowdown()
      when 1 then @_explode(damage)

  color: ->
    switch @tower.model.get('spriteIdx')
      when 0 then 0x00FF00
      when 1 then 0xFF0000
      when 2 then 0xFFFFFF
      when 3 then 0x000000

  _explode: (damage) ->
    monstersInRange = _.filter(game.wave.children, (monster) =>
      monster.position.distance(@position) < SPLASH_RANGE
    )
    _.each(monstersInRange, (monster) -> monster.damage(damage))

    emitter = new AppAtk.Views.MonsterParticles(game, @x, @y, '0xff0000', 100, 2500)
    game.add.existing(emitter)
