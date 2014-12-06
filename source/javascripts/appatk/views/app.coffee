class AppAtk.Views.App extends Phaser.Sprite
  hoverScale: 1.1
  slow: 200
  quick: 80


  @create:(game, x, y, model) ->
    tmp = new @(game, x, y, model)
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
      @installedMode()
      @game.add.tween(@).to({x: location.x, y: location.y}, 80, Phaser.Easing.Linear.None, true)
      @tweenScale(1, @quick)
      @app.storeMode()

    @events.onInputDown.add =>
      @app = AppAtk.Views.App.create(@game, @x, @y, @model)
      @bringToTop()

  tweenScale: (scale = 1, speed =@quick) ->
    game.add.tween(@scale).to({x: scale, y: scale}, speed, Phaser.Easing.Linear.None, true)

  installedMode: ->
    @events.onInputOver.removeAll()
    @events.onInputOut.removeAll()
    @events.onInputDown.removeAll()
    @events.onDragStop.removeAll()
    @input.disableDrag()