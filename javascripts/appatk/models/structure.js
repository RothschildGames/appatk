(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppAtk.Models.Structure = (function(_super) {
    __extends(Structure, _super);

    function Structure(width, height) {
      this.width = width != null ? width : 4;
      this.height = height != null ? height : 6;
      this.towersMatrix = this._generateMatrix(this.width, this.height);
      this.pathsMatrix = this._generateMatrix(this.width - 1, this.height + 1);
    }

    Structure.prototype.generateWavePath = function() {
      var nextCol, wavePath;
      wavePath = [];
      nextCol = Math.floor(Math.random() * (this.width - 1));
      _.times(this.height + 1, (function(_this) {
        return function(row) {
          var col;
          col = nextCol;
          wavePath.push(new Phaser.Point(col, row));
          if (row !== _this.height && row !== 0) {
            nextCol = Math.floor(Math.random() * (_this.width - 1));
            return wavePath.push(new Phaser.Point(nextCol, row));
          }
        };
      })(this));
      return this._sanitizedPath(wavePath);
    };

    Structure.prototype.hasTowerAt = function(row, col) {
      return this.towersMatrix[row][col] !== null;
    };

    Structure.prototype.addTowerAt = function(tower, row, col) {
      return this.towersMatrix[row][col] = tower;
    };

    Structure.prototype.removeTowerAt = function(row, col) {
      return this.towersMatrix[row][col] = null;
    };

    Structure.prototype._generateMatrix = function(width, height) {
      var towersMatrix;
      towersMatrix = [];
      _.times(height, function() {
        var row;
        row = [];
        _.times(width, function() {
          return row.push(null);
        });
        return towersMatrix.push(row);
      });
      return towersMatrix;
    };

    Structure.prototype._sanitizedPath = function(path) {
      var currentPoint, index, lastPoint, newPath, nextPoint;
      newPath = [];
      index = 0;
      lastPoint = null;
      while (index < path.length) {
        currentPoint = path[index];
        nextPoint = path[index + 1];
        if (!lastPoint || !nextPoint || (lastPoint.x === currentPoint.x && nextPoint.x !== currentPoint.x) || (lastPoint.x !== currentPoint.x)) {
          newPath.push(currentPoint);
        }
        lastPoint = currentPoint;
        index += 1;
      }
      return newPath;
    };

    return Structure;

  })(Backbone.Model);

}).call(this);
