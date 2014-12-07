(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  AppAtk.Views.HUD = (function() {
    function HUD(game, gameState) {
      this.game = game;
      this.gameState = gameState;
      this.renderWave = __bind(this.renderWave, this);
      this.renderHealth = __bind(this.renderHealth, this);
      this.renderScore = __bind(this.renderScore, this);
      game.load.image('battery', '/images/battery.png');
    }

    HUD.prototype.create = function() {
      var battery, i, shape, _i;
      this.waveShapes = [];
      for (i = _i = 0; _i <= 4; i = ++_i) {
        shape = this.game.add.graphics(17 + 15 * i, 26);
        this.waveShapes.push(shape);
      }
      this.scoreText = this.game.add.text(93, 12, "400 G");
      this.scoreText.font = 'Helvetica Neue';
      this.scoreText.fontSize = 24;
      this.scoreText.fontWeight = 200;
      this.scoreText.fill = '#FFFFFF';
      this.titleText = this.game.add.text(game.world.centerX, 12, "APPATK");
      this.titleText.anchor.setTo(.5, 0);
      this.titleText.font = 'Helvetica Neue';
      this.titleText.fontSize = 25;
      this.titleText.fontWeight = 500;
      this.titleText.fill = '#FFFFFF';
      this.healthText = this.game.add.text(680, 12, "100%");
      this.healthText.anchor.setTo(1, 0);
      this.healthText.font = 'Helvetica Neue';
      window.foo = this.healthText;
      this.healthText.fontSize = 24;
      this.healthText.fontWeight = 200;
      this.healthText.fill = '#FFFFFF';
      battery = this.game.add.sprite(738, 17, 'battery');
      battery.anchor.setTo(1, 0);
      this.batteryFill = this.game.add.graphics(691, 19);
      this.batteryFill.beginFill(0xFFFFFF, 1);
      this.batteryFill.drawRect(0, 0, 40, 14);
      this.renderHealth();
      this.renderWave();
      this.renderScore();
      this.gameState.on('change:health', this.renderHealth);
      this.gameState.on('change:gold', this.renderScore);
      return this.gameState.on('change:wave', this.renderWave);
    };

    HUD.prototype.renderScore = function() {
      return this.scoreText.text = "" + (this.gameState.get('gold')) + " G";
    };

    HUD.prototype.renderHealth = function() {
      var percent;
      percent = Math.min(Math.max(0, parseInt(this.gameState.get('health'))), 100);
      this.healthText.text = "" + percent + "%";
      this.batteryFill.scale.x = percent / 100;
      if (percent <= 20) {
        this.batteryFill.tint = 0xff3b30;
      } else {
        this.batteryFill.tint = 0xffffff;
      }
      return this.batteryFill.dirty = true;
    };

    HUD.prototype.renderWave = function() {
      var idx, shape, wave, _i, _len, _ref, _results;
      wave = Math.min(Math.max(0, parseInt(this.gameState.get('wave'))), 5);
      _ref = this.waveShapes;
      _results = [];
      for (idx = _i = 0, _len = _ref.length; _i < _len; idx = ++_i) {
        shape = _ref[idx];
        shape.clear();
        shape.lineStyle(1, 0xFFFFFF, 1);
        if (idx < wave) {
          shape.beginFill(0xFFFFFF, 1);
        }
        _results.push(shape.drawCircle(0, 0, 11));
      }
      return _results;
    };

    return HUD;

  })();

}).call(this);
