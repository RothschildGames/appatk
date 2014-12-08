class AppAtk.Views.Shop

  constructor: (@game, @shops = AppAtk.Models.shops) ->
    @locations = []
    for i in [0...@shops.length]
      @locations.push(
        {x: 115 + (120+53)*i, y: 1230}
      )

  create: ->
    @towersLayer = @game.add.group()
    @badgeLayer = @game.add.group()
    @shops.forEach (shop) =>
      location = @locations[shop.get('position')]
      shopSprite = new AppAtk.Views.TowerView(game, location.x, location.y, shop, @towersLayer)
      shopSprite.storeMode()

      shopText = @game.add.text(location.x, location.y + 70, shop.get('name'))
      shopText.anchor.setTo(.5, 0)
      shopText.font = 'Helvetica Neue'
      shopText.fontSize = 24
      shopText.fontWeight = 200
      shopText.fill = '#FFFFFF'

      shopBadge = new AppAtk.Views.Badge(game, location.x + 50, location.y - 50, shop.get('price'))
      @badgeLayer.add(shopBadge)