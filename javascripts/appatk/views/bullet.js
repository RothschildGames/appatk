(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Views.Bullet = (function(_super) {
    __extends(Bullet, _super);

    Bullet.prototype.speed = 60;

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
      this.target.damage(this.tower.model.get('damage'));
      switch (this.tower.model.get('spriteIdx')) {
        case 2:
          return this.target.slowdown();
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

    return Bullet;

  })(Phaser.Graphics);

}).call(this);
