(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Models.Shop = (function(_super) {
    __extends(Shop, _super);

    function Shop() {
      return Shop.__super__.constructor.apply(this, arguments);
    }

    Shop.prototype.defaults = {
      name: '',
      price: 1,
      spriteIdx: 0,
      position: 0,
      cooldown: 200,
      radius: 150,
      damage: 10,
      installationCooldown: 100
    };

    return Shop;

  })(Backbone.Model);

  AppAtk.Models.Shops = (function(_super) {
    __extends(Shops, _super);

    function Shops() {
      return Shops.__super__.constructor.apply(this, arguments);
    }

    Shops.prototype.model = AppAtk.Models.Shop;

    return Shops;

  })(Backbone.Collection);

  AppAtk.Models.shops = new AppAtk.Models.Shops([
    {
      name: 'Shooty',
      spriteIdx: 0,
      position: 0,
      price: 5,
      cooldown: 100,
      damage: 100
    }, {
      name: 'Splashy',
      spriteIdx: 1,
      position: 1,
      cooldown: 400,
      damage: 100,
      radius: 200,
      price: 10
    }, {
      name: 'Slowey',
      spriteIdx: 2,
      position: 2,
      damage: 20,
      price: 20
    }, {
      name: 'Snipey',
      spriteIdx: 3,
      position: 3,
      damage: 1000,
      cooldown: 1000,
      radius: 400,
      price: 30
    }
  ]);

}).call(this);
