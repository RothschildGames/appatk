(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Views.TowerView = (function(_super) {
    __extends(TowerView, _super);

    TowerView.prototype.hoverScale = 1.1;

    TowerView.prototype.slow = 200;

    TowerView.prototype.quick = 80;

    TowerView.prototype.status = null;

    function TowerView(game, x, y, model, group) {
      this.model = model;
      this.group = group;
      TowerView.__super__.constructor.call(this, game, x, y, 'apps', model.get('spriteIdx'));
      this.anchor.setTo(.5, .5);
      game.add.existing(this);
      this.group.add(this);
    }

    TowerView.prototype.storeMode = function() {
      this.status = 'store';
      AppAtk.gameState.on('change:gold', (function(_this) {
        return function() {
          return _this.onGoldChangeForStore();
        };
      })(this));
      this.buttonMode = true;
      this.inputEnabled = true;
      this.input.enableDrag(true);
      this.events.onInputOver.add((function(_this) {
        return function() {
          return _this.tweenScale(_this.hoverScale, _this.slow);
        };
      })(this));
      this.events.onInputOut.add((function(_this) {
        return function() {
          return _this.tweenScale(1, _this.slow);
        };
      })(this));
      this.events.onDragStart.add((function(_this) {
        return function() {
          var g;
          g = _this.game.add.graphics();
          g.beginFill(0xFFFFFF, 0.2);
          g.drawCircle(0, 0, _this.model.get('radius') * 2);
          _this.addChild(g);
          return _this.radiusCircle = g;
        };
      })(this));
      this.events.onDragStop.add((function(_this) {
        return function() {
          var location;
          location = _.min(AppAtk.Utils.Coords.TOWER_LOCATIONS, function(loc) {
            return _this.position.distance(loc);
          });
          _this.stopEvents();
          _this.app.storeMode();
          if (_this.position.y >= 1120 || _this.game.structure.hasTowerAt(location.row, location.col)) {
            return _this.cancel();
          } else {
            return _this.install(location);
          }
        };
      })(this));
      this.events.onInputDown.add((function(_this) {
        return function() {
          _this.app = new AppAtk.Views.TowerView(_this.game, _this.x, _this.y, _this.model, _this.group);
          return _this.bringToTop();
        };
      })(this));
      return this.onGoldChangeForStore();
    };

    TowerView.prototype.install = function(location) {
      AppAtk.trigger('installed-tower', this.model);
      this.game.structure.addTowerAt(this, location.row, location.col);
      this.game.add.tween(this).to({
        x: location.x,
        y: location.y,
        alpha: 1
      }, this.quick, Phaser.Easing.Linear.None, true);
      return this.tweenScale(1, this.quick).onComplete.add((function(_this) {
        return function() {
          _this.game.add.tween(_this.radiusCircle.scale).to({
            x: 0,
            y: 0
          }, 1200, Phaser.Easing.Bounce.Out, true, 2200).onComplete.add(function() {
            return _this.startRadiusOnHover();
          });
          return _this.cooldown(function() {
            return _this.startSeeking();
          });
        };
      })(this));
    };

    TowerView.prototype.cancel = function() {
      this.game.add.tween(this).to({
        y: this.y + 100
      }, this.quick, Phaser.Easing.Linear.None, true);
      return this.tweenScale(0).onComplete.add((function(_this) {
        return function() {
          return _this.destroy();
        };
      })(this));
    };

    TowerView.prototype.startRadiusOnHover = function() {
      return this.radiusCircle.destroy();
    };

    TowerView.prototype.tweenScale = function(scale, speed) {
      if (scale == null) {
        scale = 1;
      }
      if (speed == null) {
        speed = this.quick;
      }
      return game.add.tween(this.scale).to({
        x: scale,
        y: scale
      }, speed, Phaser.Easing.Linear.None, true);
    };

    TowerView.prototype.bounceScale = function(scale, speed) {
      if (scale == null) {
        scale = 0.9;
      }
      if (speed == null) {
        speed = this.quick;
      }
      return game.add.tween(this.scale).to({
        x: scale,
        y: scale
      }, speed, Phaser.Easing.Sinusoidal.InOut).to({
        x: 1,
        y: 1
      }, speed, Phaser.Easing.Sinusoidal.InOut).start();
    };

    TowerView.prototype.stopEvents = function() {
      this.events.onInputOver.removeAll();
      this.events.onInputOut.removeAll();
      this.events.onInputDown.removeAll();
      this.events.onDragStop.removeAll();
      return this.input.disableDrag();
    };

    TowerView.prototype.cooldown = function(cb) {
      var pie, tween;
      if (cb == null) {
        cb = function() {};
      }
      this.status = 'installing';
      this.tint = 0x666666;
      pie = new AppAtk.Views.InsallationProgress(game, 0, 0, 36);
      game.add.existing(pie);
      this.addChild(pie);
      tween = this.game.add.tween(pie);
      tween.onComplete.add((function(_this) {
        return function() {
          _this.tint = 0xFFFFFF;
          pie.destroy();
          return cb();
        };
      })(this));
      return tween.to({
        progress: 1
      }, this.model.get('installationCooldown') * 10, Phaser.Easing.Linear.None, true);
    };

    TowerView.prototype.attackCooldown = function(cb) {
      if (cb == null) {
        cb = function() {};
      }
      this.status = 'cooldown';
      return this.game.add.tween(this).to({}, this.model.get('cooldown') * 10, Phaser.Easing.Linear.None, true).onComplete.add((function(_this) {
        return function() {
          return cb();
        };
      })(this));
    };

    TowerView.prototype.update = function() {
      switch (this.status) {
        case 'seeking':
          return this.performSeek();
        case 'targeting':
          return this.performTargeting();
      }
    };

    TowerView.prototype.startSeeking = function() {
      this.target = null;
      return this.status = 'seeking';
    };

    TowerView.prototype.performSeek = function() {
      var closestMonster;
      closestMonster = _.min(game.wave.children, (function(_this) {
        return function(monster) {
          return monster.position.distance(_this.position);
        };
      })(this));
      if (this.targetInRange(closestMonster)) {
        return this.startTargeting(closestMonster);
      }
    };

    TowerView.prototype.targetInRange = function(target) {
      var distanceToTarget;
      if (target == null) {
        target = this.target;
      }
      if (!((target != null) && target.alive)) {
        return false;
      }
      distanceToTarget = target.position.distance(this.position);
      return distanceToTarget < this.model.get('radius');
    };

    TowerView.prototype.startTargeting = function(monster) {
      this.status = 'targeting';
      return this.target = monster;
    };

    TowerView.prototype.performTargeting = function() {
      if (this.targetInRange()) {
        return this.shoot();
      } else {
        return this.startSeeking();
      }
    };

    TowerView.prototype.shoot = function() {
      var bullet;
      bullet = new AppAtk.Views.Bullet(game, this);
      bullet.shootAt(this.target);
      this.bounceScale();
      return this.attackCooldown((function(_this) {
        return function() {
          return _this.status = 'targeting';
        };
      })(this));
    };

    TowerView.prototype.onGoldChangeForStore = function() {
      if (this.status !== 'store') {
        return;
      }
      if (this.model.get('price') <= AppAtk.gameState.get('gold')) {
        this.alpha = 1;
        return this.inputEnabled = true;
      } else {
        this.alpha = 0.5;
        return this.inputEnabled = false;
      }
    };

    return TowerView;

  })(Phaser.Sprite);

}).call(this);
