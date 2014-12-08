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
      damage: 100,
      radius: 170
    }, {
      name: 'Slowey',
      spriteIdx: 2,
      position: 2,
      price: 20,
      cooldown: 100,
      damage: 50,
      radius: 120
    }, {
      name: 'Splashy',
      spriteIdx: 1,
      position: 1,
      price: 14,
      cooldown: 700,
      damage: 200,
      radius: 180
    }, {
      name: 'Snipey',
      spriteIdx: 3,
      position: 3,
      price: 35,
      cooldown: 750,
      damage: 1000,
      radius: 400
    }
  ]);

}).call(this);
