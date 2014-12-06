class AppAtk.Views.App extends Phaser.Sprite
  hoverScale: 1.1
  slow: 200
  quick: 80


  @create:(game, x, y, model) ->
    tmp = new @(game, x, y, model)
    window.app = tmp
    game.add.existing(tmp)
    tmp

  constructor: (game, x, y, @model) ->
    super(game, x, y, 'apps', model.get('spriteIdx'))
    @anchor.setTo(.5, .5)

  storeMode: ->
    @buttonMode = true
    @inputEnabled = true
    @input.enableDrag(true)

    @events.onInputOver.add =>
      @tweenScale(@hoverScale, @slow)

    @events.onInputOut.add =>
      @tweenScale(1, @slow)

    @events.onDragStop.add =>
      location = _.min(AppAtk.Utils.Coords.TOWER_LOCATIONS, (loc) => @position.distance(loc))
      @stopEvents()
      @app.storeMode()
      if @game.structure.hasTowerAt(location.row, location.col)
        @cancel()
      else
        @install(location)

    @events.onInputDown.add =>
      @app = AppAtk.Views.App.create(@game, @x, @y, @model)
      @bringToTop()

  install: (location) ->

    @game.structure.addTowerAt(@, location.row, location.col)
    @game.add.tween(@).to({x: location.x, y: location.y}, @quick, Phaser.Easing.Linear.None, true)
    @tweenScale(1, @quick)

  cancel: ->
    tween = @game.add.tween(@)
    tween.to({y: @y + 100}, @quick, Phaser.Easing.Linear.None, true)
    tween.onComplete.add =>
      @destroy()
    @tweenScale(0)

  tweenScale: (scale = 1, speed =@quick) ->
    game.add.tween(@scale).to({x: scale, y: scale}, speed, Phaser.Easing.Linear.None, true)

  stopEvents: ->
    @events.onInputOver.removeAll()
    @events.onInputOut.removeAll()
    @events.onInputDown.removeAll()
    @events.onDragStop.removeAll()
    @input.disableDrag()

  recharge: ->
    @tint = 0x6666FF
    @shape = @game.add.graphics(0, 0)
    @shape.lineStyle(6, 0xFFFFFF, 0.5)
    @shape.drawCircle(0, 0, 74)

#    this.bmp.ctx.beginPath();
#    this.bmp.ctx.arc(this._radius, this._radius, this._radius, 0, (Math.PI * 2) * progress, true);
#    this.bmp.ctx.lineTo(this._radius, this._radius);
#    this.bmp.ctx.closePath();

    @shape.lineStyle(60, 0xFF0000, 0.5)
#    @shape.beginFill(0xFF0000, 0.5)
    @shape.drawShape(@shape.arc(@shape.x, @shape.y, 6, 0, 0.4))
    @addChild(@shape)
