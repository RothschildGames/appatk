class AppAtk.Views.InsallationProgress extends Phaser.Sprite

  constructor: (game, x, y, radius, color, angle)->
    @_radius = radius || 40
    @_progress = 0
    @bmp = game.add.bitmapData(radius * 2, radius * 2)
    super(game, x, y, @bmp)
    @anchor.set(.5)
    @angle = angle || -90
    @color = color || '#fff'
    @opacity = 0.5
    @updateProgress()

  Object.defineProperties @prototype,
    progress:
      get: -> @_progress
      set: (val) -> @setProgress(val)


  updateProgress: ->
    progress = Phaser.Math.clamp(@_progress, 0.00001, 0.99999)
    @bmp.clear()
    @bmp.ctx.globalAlpha = @opacity
    @bmp.ctx.fillStyle = @color
    @bmp.ctx.beginPath()
    @bmp.ctx.arc(@_radius, @_radius, (@_radius - 4), 0, (Math.PI * 2) * progress, false)
    @bmp.ctx.lineTo(@_radius, @_radius)
    @bmp.ctx.closePath()
    @bmp.ctx.fill()

    @bmp.ctx.beginPath()
    @bmp.ctx.strokeStyle = @color
    @bmp.ctx.lineWidth = 4
    @bmp.ctx.arc(@_radius, @_radius, @_radius - 4 , 0, (Math.PI * 2), false)
    @bmp.ctx.stroke()

    @bmp.dirty = true

  setProgress: (val) ->
    @_progress = Phaser.Math.clamp(val, 0, 1)
    @updateProgress()
