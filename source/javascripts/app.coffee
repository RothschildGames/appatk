# console.log("ASD")
# preload = ->
#   game.load.image('people', '/small-people.png');
#
#
# create = ->
#
# person;

game = new Phaser.Game 800, 600, Phaser.CANVAS, 'phaser-example',
  preload: ->
    game.load.spritesheet('people', '/images/small-people.png', 16, 16)
    # game.load.spritesheet('landscape', '/images/landscapeTiles_sheet.png', 16, 16)
    # landscapeTiles_sheet.xml
    game.load.atlasXML('landscape', '/images/landscapeTiles_sheet.png', '/images/landscapeTiles_sheet.xml')
    game.plugins.add(new Phaser.Plugin.Isometric(game));
    game.iso.anchor.setTo(0.5, 0.2);


  create: ->
    person = game.add.sprite(0, 0, 'people')
    window.isoGroup = game.add.group();

    x = 72
    for i in [0..100]
      for j in [0..100]
        game.add.isoSprite(i*x, j*x, 0, 'landscape', 20, isoGroup).anchor.set(0.5, 0);
    # a.anchor.set(0.5)
    # game.add.isoSprite(x, 0, 0, 'landscape', 21, isoGroup).anchor.set(0.5, 1);
    # game.add.isoSprite(x, x, 0, 'landscape', 20, isoGroup).anchor.set(0.5, 1);
    # game.add.isoSprite(x, x*2, 0, 'landscape', 22, isoGroup).anchor.set(0.5, 1);
    # game.add.isoSprite(x*2, x*2, 0, 'landscape', 23, isoGroup).anchor.set(0.5, 1);

    # a.anchor.set(0.5)

    # foo = game.add.sprite(0, 0, 'landscape')

    person.scale.x = 2
    person.scale.y = 2
    person.anchor.setTo(.5, .5)

    window.person = person
    person.animations.add('walk', [0,1,0,2], 8, true)
    window.cursorPos = new Phaser.Plugin.Isometric.Point3();


  update: ->
    walking = false

    if (game.input.keyboard.isDown(Phaser.Keyboard.RIGHT))
      person.x += 4
      person.scale.x = 2
      walking = true
    else if (game.input.keyboard.isDown(Phaser.Keyboard.LEFT))
      person.x -= 4
      person.scale.x = -2
      walking = true

    if (game.input.keyboard.isDown(Phaser.Keyboard.DOWN))
      person.y += 4
      walking = true
    else if (game.input.keyboard.isDown(Phaser.Keyboard.UP))
      person.y -= 4
      walking = true

    if walking
      person.animations.play('walk')
    else
      person.animations.stop('walk')

    game.iso.unproject(game.input.activePointer.position, cursorPos)
    #
    #     // Loop through all tiles and test to see if the 3D position from above intersects with the automatically generated IsoSprite tile bounds.
    isoGroup.forEach (tile) ->
      inBounds = tile.isoBounds.containsXY(cursorPos.x, cursorPos.y)
      # // If it does, do a little animation and tint change.
      if (!tile.selected && inBounds)
          tile.selected = true;
          tile.tint = 0xAAAAAA;
          # game.add.tween(tile).to({ isoZ: 4 }, 200, Phaser.Easing.Quadratic.InOut, true);

      if (tile.selected && inBounds && game.input.activePointer.isDown)
        # game.add.tween(tile).to({frame: tile.frame + 10}, 200, Phaser.Easing.Quadratic.InOut, false)
        tile.frame += 1
        tile.selected = false
        tile.tint = 0xffffff
        # tile.frame += 1


      # // If not, revert back to how it was.
      else if (tile.selected && !inBounds)
          tile.selected = false;
          tile.tint = 0xffffff;
          # game.add.tween(tile).to({ isoZ: 0 }, 200, Phaser.Easing.Quadratic.InOut, true);
