jumpTimer = 0
game = new Phaser.Game 600, 300, Phaser.CANVAS, 'phaser-example',
  preload: ->
    game.load.spritesheet('indy', '/images/indy.png', 36, 40)
    game.load.image('background', '/images/room-floor.png');
    game.load.image('platform', '/images/platform.png');

  create: ->
    bg = game.add.tileSprite(0, 0, 1920, 400, 'background');

    game.world.setBounds(0, 0, 1920, 400);

    player = game.add.sprite(0, 0, 'indy')
    player.anchor.setTo(.5, .5)

    window.player = player
    player.animations.add('walk', [0,1,2,1], 8, true)
    player.animations.add('jump', [3], 8, true)

    game.physics.startSystem(Phaser.Physics.ARCADE)
    # game.physics.arcade.gravity.y = 300;

    game.physics.enable(player, Phaser.Physics.ARCADE);
    player.body.collideWorldBounds = true;
    player.body.gravity.y = 1000;
    player.body.maxVelocity.y = 500;

    platforms = game.add.group()
    platforms.enableBody = true
    platforms.physicsBodyType = Phaser.Physics.ARCADE;

    platform = platforms.create(400, 340, 'platform')
    platform.body.immovable = true;

    platform = platforms.create(500, 300, 'platform')
    platform.body.immovable = true;

    platform = platforms.create(700, 260, 'platform')
    platform.body.immovable = true;

    window.platforms = platforms

    cursors = game.input.keyboard.createCursorKeys();
    window.cursors = cursors
    game.camera.follow(player)

  update: ->
    game.physics.arcade.collide(player, platforms);

    player.body.velocity.x = 0;

    if cursors.left.isDown
      player.body.velocity.x = -150;
      player.scale.x = -1
      player.animations.play('walk') unless player.body.velocity.y != 0
    else if (cursors.right.isDown)
      player.body.velocity.x = +150;
      player.scale.x = +1
      player.animations.play('walk') unless player.body.velocity.y != 0
    else if player.body.velocity.y >= 0
      player.animations.stop()
      player.frame = 0


    if (cursors.up.isDown && player.body.velocity.y == 0 && game.time.now > jumpTimer)
      player.body.velocity.y = -500;
      jumpTimer = game.time.now + 750;
      player.animations.play('jump')
window.game = game
