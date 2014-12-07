class AppAtk.Views.TowerView extends Phaser.Sprite
  hoverScale: 1.1
  slow: 200
  quick: 80
  status: null

  @create:(game, x, y, model) ->
    tmp = new @(game, x, y, model)
    window.app = tmp
    game.add.existing(tmp)
    tmp

  constructor: (game, x, y, @model) ->
    super(game, x, y, 'apps', model.get('spriteIdx'))
    @anchor.setTo(.5, .5)

  storeMode: ->
    @status = 'store'
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
      if @position.y >= 1120 || @game.structure.hasTowerAt(location.row, location.col)
        @cancel()
      else
        @install(location)

    @events.onInputDown.add =>
      @app = AppAtk.Views.TowerView.create(@game, @x, @y, @model)
      @bringToTop()

  install: (location) ->
    @game.structure.addTowerAt(@, location.row, location.col)
    @game.add.tween(@).to({x: location.x, y: location.y}, @quick, Phaser.Easing.Linear.None, true)
    @tweenScale(1, @quick).onComplete.add =>
      @cooldown =>
        @startSeeking()

  cancel: ->
    @game.add.tween(@).to({y: @y + 100}, @quick, Phaser.Easing.Linear.None, true)
    @tweenScale(0).onComplete.add =>
      @destroy()

  tweenScale: (scale = 1, speed =@quick) ->
    game.add.tween(@scale).to({x: scale, y: scale}, speed, Phaser.Easing.Linear.None, true)

  stopEvents: ->
    @events.onInputOver.removeAll()
    @events.onInputOut.removeAll()
    @events.onInputDown.removeAll()
    @events.onDragStop.removeAll()
    @input.disableDrag()

  cooldown: (cb = ->) ->
    @status = 'installing'
    @tint = 0x666666
    pie = new AppAtk.Views.InsallationProgress(game, 0, 0, 36);
    game.add.existing(pie)
    @addChild(pie)
    tween = @game.add.tween(pie)
    tween.onComplete.add =>
      @tint = 0xFFFFFF
      pie.destroy()
      cb()
    tween.to({progress: 1}, @model.get('installationCooldown') * 10, Phaser.Easing.Linear.None, true)

  attackCooldown: (cb = ->) ->
    @status = 'cooldown'
    @game.add.tween(@).to({}, @model.get('cooldown') * 10, Phaser.Easing.Linear.None, true).onComplete.add =>
      cb()

  update: ->
    switch @status
      when 'seeking' then @performSeek()
      when 'targeting' then @performTargeting()

  startSeeking: ->
    @target.tint = 0xFFFFFF if @target?
    @target = null
    @status = 'seeking'

  performSeek: ->
    closestMonster = _.min(game.wave.children, (monster) =>
      monster.position.distance(@position)
    )
    if @targetInRange(closestMonster)
      @startTargeting(closestMonster)

  targetInRange: (target = @target) ->
    return false unless target?
    distanceToTarget = target.position.distance(@position)
    distanceToTarget < @model.get('radius')

  startTargeting: (monster) ->
    @status = 'targeting'
    @target = monster
    monster.tint = 0x00FF00

  performTargeting: ->
    if @targetInRange()
      @shoot()
    else
      @startSeeking()

  shoot: ->
    bullet = new AppAtk.Views.Bullet(game, @)
    bullet.shootAt @target
    @attackCooldown =>
      @status = 'targeting'