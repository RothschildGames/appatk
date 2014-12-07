class AppAtk.Views.MonsterDeath extends Phaser.Particles.Arcade.Emitter

  constructor: (game, x, y, color) ->
    quantity = 25
    super(game, x, y, quantity)

    @makeParticles('death-particle')
    @lifespan = 1000
    @forEach((particle) => particle.tint = color)
    @gravity = 1
    @explode(@lifespan, quantity)

  update: ->
    @forEachAlive((particle) => particle.alpha = (particle.lifespan / @lifespan))
