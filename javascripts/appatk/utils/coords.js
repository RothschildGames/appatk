(function() {
  AppAtk.Utils.Coords = (function() {
    var i, j, _i, _j;

    function Coords() {}

    Coords.HOR_GUTTER = 53;

    Coords.VER_GUTTER = 57.5;

    Coords.EDGE_HOR_GUTTER = 55;

    Coords.EDGE_VER_GUTTER = 70;

    Coords.ICON_WIDTH = 120;

    Coords.ICON_HEIGHT = 119;

    Coords.TOWER_LOCATIONS = [];

    for (i = _i = 0; _i <= 4; i = ++_i) {
      for (j = _j = 0; _j <= 5; j = ++_j) {
        Coords.TOWER_LOCATIONS.push({
          x: 55 + 60 + (120 + 53) * i,
          y: 59 + 60 + (120 + 56) * j,
          col: i,
          row: j
        });
      }
    }

    Coords.wavePathWorldPos = function(pos, specialType) {
      var x, y;
      if (specialType == null) {
        specialType = null;
      }
      x = (this.ICON_WIDTH * (pos.x + 1)) + this.EDGE_HOR_GUTTER + (this.HOR_GUTTER * pos.x) + (this.HOR_GUTTER * 0.5);
      y = (this.ICON_HEIGHT + this.VER_GUTTER) * pos.y;
      if (specialType === 'last') {
        y += this.EDGE_VER_GUTTER + (this.HOR_GUTTER * 0.5);
      } else if (specialType === 'first') {
        y -= 20;
      } else {
        y += this.VER_GUTTER * 0.5;
      }
      return new Phaser.Point(x, y);
    };

    return Coords;

  })();

}).call(this);
