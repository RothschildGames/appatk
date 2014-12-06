class AppAtk.Utils.Coords

  @HOR_GUTTER = 53
  @VER_GUTTER = 57.5
  @EDGE_HOR_GUTTER = 55
  @EDGE_VER_GUTTER = 56
  @ICON_WIDTH = 120
  @ICON_HEIGHT = 119

  @TOWER_LOCATIONS = []
  for i in [0..4]
    for j in [0..5]
      @TOWER_LOCATIONS.push({x: 55+60 + (120+53)*i, y: 59+60 + (120+56)*j })

  @wavePathWorldPos: (pos, specialType = null) ->
    x = (@ICON_WIDTH * (pos.x + 1)) + @EDGE_HOR_GUTTER + (@HOR_GUTTER * (pos.x)) + (@HOR_GUTTER * 0.5)
    y = (@ICON_HEIGHT + @VER_GUTTER) * (pos.y)
    if specialType == 'last'
      y += @EDGE_VER_GUTTER + (@HOR_GUTTER * 0.5)
    else if specialType == 'first'
      y -= 20
    else
      y += (@VER_GUTTER * 0.5)

    new Phaser.Point(x, y)