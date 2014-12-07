(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Views.InsallationProgress = (function(_super) {
    __extends(InsallationProgress, _super);

    function InsallationProgress(game, x, y, radius, color, angle) {
      this._radius = radius || 40;
      this._progress = 0;
      this.bmp = game.add.bitmapData(radius * 2, radius * 2);
      InsallationProgress.__super__.constructor.call(this, game, x, y, this.bmp);
      this.anchor.set(.5);
      this.angle = angle || -90;
      this.color = color || '#fff';
      this.opacity = 0.5;
      this.updateProgress();
    }

    Object.defineProperties(InsallationProgress.prototype, {
      progress: {
        get: function() {
          return this._progress;
        },
        set: function(val) {
          return this.setProgress(val);
        }
      }
    });

    InsallationProgress.prototype.updateProgress = function() {
      var progress;
      progress = Phaser.Math.clamp(this._progress, 0.00001, 0.99999);
      this.bmp.clear();
      this.bmp.ctx.globalAlpha = this.opacity;
      this.bmp.ctx.fillStyle = this.color;
      this.bmp.ctx.beginPath();
      this.bmp.ctx.arc(this._radius, this._radius, this._radius - 4, 0, (Math.PI * 2) * progress, false);
      this.bmp.ctx.lineTo(this._radius, this._radius);
      this.bmp.ctx.closePath();
      this.bmp.ctx.fill();
      this.bmp.ctx.beginPath();
      this.bmp.ctx.strokeStyle = this.color;
      this.bmp.ctx.lineWidth = 4;
      this.bmp.ctx.arc(this._radius, this._radius, this._radius - 4, 0, Math.PI * 2, false);
      this.bmp.ctx.stroke();
      return this.bmp.dirty = true;
    };

    InsallationProgress.prototype.setProgress = function(val) {
      this._progress = Phaser.Math.clamp(val, 0, 1);
      return this.updateProgress();
    };

    return InsallationProgress;

  })(Phaser.Sprite);

}).call(this);
