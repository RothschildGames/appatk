(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Views.Notification = (function(_super) {
    __extends(Notification, _super);

    function Notification(game) {
      var text;
      this.game = game;
      Notification.__super__.constructor.call(this, game, 0, 0);
      this.beginFill(0x000000, 0.8);
      this.drawRect(0, 0, game.width, 128);
      this.beginFill(0xffcc00, 1);
      this.drawRoundedRect(30, 15, 40, 40, 5);
      this.beginFill(0x757378, 1);
      this.drawRoundedRect((game.width - 74) / 2, 110, 74, 10, 7);
      game.add.existing(this);
      text = this.game.add.text(92, 18, 'AppAtk');
      text.font = 'Helvetica Neue';
      text.fontSize = 27;
      text.fontWeight = 500;
      text.fill = '#FFFFFF';
      this.addChild(text);
      text = this.game.add.text(209, 21, 'now');
      text.font = 'Helvetica Neue';
      text.fontSize = 22;
      text.fontWeight = 200;
      text.fill = '#939290';
      this.addChild(text);
      text = this.game.add.text(92, 49, 'Next wave in 30s');
      text.font = 'Helvetica Neue';
      text.fontSize = 26;
      text.fontWeight = 200;
      text.fill = '#FFFFFF';
      this.addChild(text);
      this.notificationText = text;
      this.y = -this.height;
    }

    Notification.prototype.showNotification = function(message, delay, cb) {
      var tween;
      if (message == null) {
        message = "Next wave in 30s";
      }
      if (delay == null) {
        delay = 1800;
      }
      if (cb == null) {
        cb = function() {};
      }
      this.notificationText.text = message;
      tween = this.game.add.tween(this).to({
        y: 0
      }, 500, Phaser.Easing.Quadratic.Out).to({
        y: -this.height
      }, 200, Phaser.Easing.Quadratic.In, false, delay);
      tween.onComplete.add(cb);
      return tween.start();
    };

    return Notification;

  })(Phaser.Graphics);

}).call(this);
