(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Views.MonsterView = (function(_super) {
    var BASE_ROTATION_SPEED, HIT_SCALE, HIT_SPEED, SLOWDOWN_COOLDOWN, SLOWDOWN_RATIO, SPEED_SLOW_MULTIPLIER;

    __extends(MonsterView, _super);

    SPEED_SLOW_MULTIPLIER = 8;

    BASE_ROTATION_SPEED = 70;

    SLOWDOWN_RATIO = 0.7;

    SLOWDOWN_COOLDOWN = 1200;

    HIT_SPEED = 100;

    HIT_SCALE = 0.7;

    function MonsterView(game, x, y, monster) {
      this.monster = monster;
      MonsterView.__super__.constructor.call(this, game, x, y, this.monster.get('image'));
      this.health = this.monster.get('hp');
      this.anchor.setTo(0.5, 0.5);
      this.animations.add('walk', [0, 1, 2, 3, 3, 2, 1, 0, 6, 5, 4, 5, 6], 6, true);
      this.animations.play('walk');
      this.scale = new Phaser.Point(this.monster.get('scale'), this.monster.get('scale'));
      this.events.onKilled.add((function(_this) {
        return function() {
          return _this._onKilled();
        };
      })(this));
    }

    MonsterView.prototype.generatePathTween = function(path) {
      var angle, distance, i, isLast, lastIndex, lastPoint, lastWorldPoint, point, worldPoint, _i, _len;
      this.path = path;
      this.monsterTween = game.add.tween(this);
      lastIndex = path.length - 1;
      lastPoint = null;
      for (i = _i = 0, _len = path.length; _i < _len; i = ++_i) {
        point = path[i];
        isLast = i === path.length - 1;
        worldPoint = AppAtk.Utils.Coords.wavePathWorldPos(point, isLast ? 'last' : null);
        if (lastWorldPoint) {
          distance = Phaser.Point.distance(worldPoint, lastWorldPoint);
          if (worldPoint.x === lastWorldPoint.x) {
            angle = 0;
          } else if (worldPoint.x > lastWorldPoint.x) {
            angle = -90;
          } else {
            angle = 90;
          }
          this.monsterTween.to({
            angle: angle
          }, BASE_ROTATION_SPEED / this.monster.get('speed'));
          this.monsterTween.to({
            x: worldPoint.x,
            y: worldPoint.y
          }, distance / this.monster.get('speed') * SPEED_SLOW_MULTIPLIER);
        }
        lastWorldPoint = worldPoint;
      }
      this.monsterTween.onComplete.add((function(_this) {
        return function() {
          AppAtk.trigger('lost-life', _this.monster.get('damage'));
          return _this.destroy();
        };
      })(this));
      return this.monsterTween.start();
    };

    MonsterView.prototype._onKilled = function() {
      var emitter;
      this.monsterTween.stop();
      AppAtk.trigger('monster-killed', this.monster.get('loot'));
      emitter = new AppAtk.Views.MonsterParticles(game, this.x, this.y, this.monster.get('tint'));
      return game.add.existing(emitter);
    };

    MonsterView.prototype.damage = function() {
      var emitter;
      MonsterView.__super__.damage.apply(this, arguments);
      if (this.health > 0) {
        AppAtk.trigger('monster-hit');
      }
      game.add.tween(this.scale).to({
        x: HIT_SCALE,
        y: HIT_SCALE
      }, HIT_SPEED, Phaser.Easing.Sinusoidal.InOut).to({
        x: 1,
        y: 1
      }, HIT_SPEED, Phaser.Easing.Sinusoidal.InOut).start();
      emitter = new AppAtk.Views.MonsterParticles(game, this.x, this.y, this.monster.get('tint'), 15, 250);
      return game.add.existing(emitter);
    };

    MonsterView.prototype.slowdown = function() {
      this.monsterTween.timeScale *= SLOWDOWN_RATIO;
      this.tint = 0xFFFFFF;
      return setTimeout(((function(_this) {
        return function() {
          _this.monsterTween.timeScale /= SLOWDOWN_RATIO;
          return _this.tint = _this.monster.get('tint');
        };
      })(this)), SLOWDOWN_COOLDOWN);
    };

    return MonsterView;

  })(Phaser.Sprite);

}).call(this);
