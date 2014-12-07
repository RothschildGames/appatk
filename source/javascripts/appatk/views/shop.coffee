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
      shopSprite = AppAtk.Views.TowerView.create(game, location.x, location.y, shop)
      shopSprite.storeMode()
      shopText = @game.add.text(location.x, location.y + 70, shop.get('name'))
      shopText.anchor.setTo(.5, 0)
      shopText.font = 'Helvetica Neue'
      shopText.fontSize = 24
      shopText.fontWeight = 200
      shopText.fill = '#FFFFFF'

      shopBadge = new AppAtk.Views.Badge(game, location.x + 50, location.y - 50, shop.get('price'))
      shopBadge.z = 1000000