class AppAtk.Views.Bullet extends Phaser.Graphics

  speed: 60

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
    @target.damage(@tower.model.get('damage'))
    switch @tower.model.get('spriteIdx')
      when 2 then @target.slowdown()

  color: ->
    switch @tower.model.get('spriteIdx')
      when 0 then 0x00FF00
      when 1 then 0xFF0000
      when 2 then 0xFFFFFF
      when 3 then 0x000000