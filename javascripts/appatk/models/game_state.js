(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Models.GameState = (function(_super) {
    __extends(GameState, _super);

    function GameState() {
      return GameState.__super__.constructor.apply(this, arguments);
    }

    GameState.prototype.defaults = {
      wave: 1,
      health: 100,
      gold: 10,
      lowHealth: false,
      gameOver: false
    };

    GameState.prototype.initialize = function() {
      this.listenTo(AppAtk, 'lost-life', this._lostLife);
      this.listenTo(AppAtk, 'monster-killed', this._gotLoot);
      return this.listenTo(AppAtk, 'installed-tower', this._installedTower);
    };

    GameState.prototype.waveUp = function() {
      return this.set('wave', this.get('wave') + 1);
    };

    GameState.prototype._lostLife = function(damage) {
      this.set('health', this.get('health') - damage);
      if (this.get('health') <= 20) {
        this.set('lowHealth', true);
      }
      if (this.get('health') <= 0) {
        return this.set('gameOver', true);
      }
    };

    GameState.prototype._gotLoot = function(loot) {
      return this.set('gold', this.get('gold') + loot);
    };

    GameState.prototype._installedTower = function(tower) {
      return this.set('gold', this.get('gold') - tower.get('price'));
    };

    return GameState;

  })(Backbone.Model);

}).call(this);
