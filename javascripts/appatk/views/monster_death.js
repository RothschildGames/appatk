(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Views.MonsterDeath = (function(_super) {
    __extends(MonsterDeath, _super);

    function MonsterDeath(game, x, y, color) {
      var quantity;
      quantity = 25;
      MonsterDeath.__super__.constructor.call(this, game, x, y, quantity);
      this.makeParticles('death-particle');
      this.lifespan = 1000;
      this.forEach((function(_this) {
        return function(particle) {
          return particle.tint = color;
        };
      })(this));
      this.gravity = 1;
      this.explode(this.lifespan, quantity);
    }

    MonsterDeath.prototype.update = function() {
      return this.forEachAlive((function(_this) {
        return function(particle) {
          return particle.alpha = particle.lifespan / _this.lifespan;
        };
      })(this));
    };

    return MonsterDeath;

  })(Phaser.Particles.Arcade.Emitter);

}).call(this);
