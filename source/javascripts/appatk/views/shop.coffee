class AppAtk.Views.Shop

  constructor: (@game, @shops = AppAtk.Models.shops) ->
    game.load.spritesheet('apps', '/images/apps.png' ,120, 119)
    @locations = []
    for i in [0...@shops.length]
      @locations.push(
        {x: 115 + (120+53)*i, y: 1230}
      )

  create: ->
    @shops.forEach (shop) =>
      location = @locations[shop.get('position')]
      sprite = @game.add.sprite(location.x,
                                location.y,
                                'apps',
                                shop.get('spriteIdx'))
      sprite.anchor.setTo(.5, .5)
      shopText = @game.add.text(location.x, location.y + 70, shop.get('name'))
      shopText.anchor.setTo(.5, 0)
      shopText.font = 'Helvetica Neue'
      shopText.fontSize = 24
      shopText.fontWeight = 200
      shopText.fill = '#FFFFFF'

      sprite.buttonMode = true
      sprite.inputEnabled = true
      sprite.events.onInputOver.add(
        (-> game.add.tween(@scale).to({x: 1.1, y: 1.1}, 200, Phaser.Easing.Linear.None, true))
        , sprite
      )
      sprite.events.onInputOut.add(
        (-> game.add.tween(@scale).to({x: 1, y: 1}, 200, Phaser.Easing.Linear.None, true))
        , sprite
      )
      sprite.events.onInputDown.add(
        (-> console.log(@))
        , sprite
      )
      # sprite.events.onInputOver.add =>
      #   game.add.tween(sprite.scale).to({x: 1.1, y: 1.1}, 200, Phaser.Easing.Linear.None, true)
    # # @sprite.events.onInputDown.add =>
    #   # console.log('click')
    # # newTower = game.add.sprite(@sprite.x, @sprite.y, 'icon-02')
    # # newTower.anchor.setTo(.5, .5)
    # # newTower.inputEnabled = true
    #
    # # newTower.input.enableSnap(120, 120, false, true, 55, 59);
    # # @sprite.input.startDrag(game.input.activePointer)
    # # newTower.events.onDragStart.add =>
    #   # game.add.tween(newTower.scale).to({x: 1, y: 1}, 50, Phaser.Easing.Linear.None, true)
    #
    # @sprite.input.enableDrag(true)
    # @sprite.events.onDragStop.add =>
    #   location = _.min @locations, (loc) =>
    #     @sprite.position.distance(loc)
    #   game.add.tween(@sprite).to({x: location.x, y: location.y}, 80, Phaser.Easing.Linear.None, true)
