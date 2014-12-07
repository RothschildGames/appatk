(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Models.Monster = (function(_super) {
    __extends(Monster, _super);

    function Monster() {
      return Monster.__super__.constructor.apply(this, arguments);
    }

    Monster.prototype.defaults = function() {
      return {
        tint: 0xffffff,
        scale: 1,
        hp: 5,
        damage: 5,
        speed: 1,
        loot: 1
      };
    };

    return Monster;

  })(Backbone.Model);

}).call(this);
