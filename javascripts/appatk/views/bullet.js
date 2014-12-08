(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Views.Bullet = (function(_super) {
    var SPLASH_RANGE;

    __extends(Bullet, _super);

    Bullet.prototype.speed = 150;

    SPLASH_RANGE = 120;

    function Bullet(game, tower) {
      this.tower = tower;
      Bullet.__super__.constructor.call(this, game, this.tower.x, this.tower.y);
      this.beginFill(this.color(), 1);
      this.drawCircle(0, 0, 12);
      game.add.existing(this);
    }

    Bullet.prototype.shootAt = function(target, cb) {
      this.target = target;
      if (cb == null) {
        cb = function() {};
      }
      return game.add.tween(this).to({
        x: this.target.x,
        y: this.target.y
      }, this.speed, Phaser.Easing.Linear.None, true).onComplete.add((function(_this) {
        return function() {
          _this.hit();
          return _this.destroy();
        };
      })(this));
    };

    Bullet.prototype.hit = function() {
      var damage;
      damage = this.tower.model.get('damage');
      this.target.damage(this.tower.model.get('damage'));
      switch (this.tower.model.get('spriteIdx')) {
        case 2:
          return this.target.slowdown();
        case 1:
          return this._explode(damage);
      }
    };

    Bullet.prototype.color = function() {
      switch (this.tower.model.get('spriteIdx')) {
        case 0:
          return 0x00FF00;
        case 1:
          return 0xFF0000;
        case 2:
          return 0xFFFFFF;
        case 3:
          return 0x000000;
      }
    };

    Bullet.prototype._explode = function(damage) {
      var emitter, monstersInRange;
      monstersInRange = _.filter(game.wave.children, (function(_this) {
        return function(monster) {
          return monster.position.distance(_this.position) < SPLASH_RANGE;
        };
      })(this));
      _.each(monstersInRange, function(monster) {
        return monster.damage(damage);
      });
      emitter = new AppAtk.Views.MonsterParticles(game, this.x, this.y, '0xff0000', 50, 1500);
      return game.add.existing(emitter);
    };

    return Bullet;

  })(Phaser.Graphics);

}).call(this);
