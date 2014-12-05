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
  create: ->
    person = game.add.sprite(0, 0, 'people')
    person.anchor.setTo(.5, .5)
    # person.scale.x = 4
    person.scale.y = 2
    window.person = person
    person.animations.add('walk', [0,1,0,2], 8, true)

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
