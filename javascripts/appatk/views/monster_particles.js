(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Views.MonsterParticles = (function(_super) {
    __extends(MonsterParticles, _super);

    function MonsterParticles(game, x, y, color, quantity, lifespan) {
      if (quantity == null) {
        quantity = 25;
      }
      if (lifespan == null) {
        lifespan = 1000;
      }
      MonsterParticles.__super__.constructor.call(this, game, x, y, quantity);
      this.makeParticles('death-particle');
      this.lifespan = lifespan;
      this.forEach((function(_this) {
        return function(particle) {
          return particle.tint = color;
        };
      })(this));
      this.gravity = 1;
      this.explode(this.lifespan, quantity);
    }

    MonsterParticles.prototype.update = function() {
      return this.forEachAlive((function(_this) {
        return function(particle) {
          return particle.alpha = particle.lifespan / _this.lifespan;
        };
      })(this));
    };

    return MonsterParticles;

  })(Phaser.Particles.Arcade.Emitter);

}).call(this);
