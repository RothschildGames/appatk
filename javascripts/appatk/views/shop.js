(function() {
  AppAtk.Views.Shop = (function() {
    function Shop(game, shops) {
      var i, _i, _ref;
      this.game = game;
      this.shops = shops != null ? shops : AppAtk.Models.shops;
      this.locations = [];
      for (i = _i = 0, _ref = this.shops.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        this.locations.push({
          x: 115 + (120 + 53) * i,
          y: 1230
        });
      }
    }

    Shop.prototype.create = function() {
      this.towersLayer = this.game.add.group();
      this.badgeLayer = this.game.add.group();
      return this.shops.forEach((function(_this) {
        return function(shop) {
          var location, shopBadge, shopSprite, shopText;
          location = _this.locations[shop.get('position')];
          shopSprite = new AppAtk.Views.TowerView(game, location.x, location.y, shop, _this.towersLayer);
          shopSprite.storeMode();
          shopText = _this.game.add.text(location.x, location.y + 70, shop.get('name'));
          shopText.anchor.setTo(.5, 0);
          shopText.font = 'Helvetica Neue';
          shopText.fontSize = 24;
          shopText.fontWeight = 200;
          shopText.fill = '#FFFFFF';
          shopBadge = new AppAtk.Views.Badge(game, location.x + 50, location.y - 50, shop.get('price'));
          return _this.badgeLayer.add(shopBadge);
        };
      })(this));
    };

    return Shop;

  })();

}).call(this);
