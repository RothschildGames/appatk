game = new Phaser.Game 250*3, 445*3, Phaser.CANVAS, 'drawing-canvas',
  init: ->
    game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT
    @locations = []
    for i in [0..4]
      for j in [0..5]
        @locations.push({x: 55+60 + (120+53)*i, y: 59+60 + (120+57)*j })

  preload: ->
    game.load.image('background', '/images/bg.png')
    game.load.image('icon-01', '/images/app-atk-icon.png')
    game.load.image('icon-02', '/images/icon-02.png')
    game.load.image('battery', '/images/battery.png')
    game.load.spritesheet('monster', '/images/monster.png', 42, 33)

  create: ->
    bg = game.add.sprite(0, 0, 'background')

    @gameState = new AppAtk.Models.GameState()
    @hud = new AppAtk.Views.HUD(game, @gameState)


    @sprite = game.add.sprite(634, 1230, 'icon-01')
    @sprite.anchor.setTo(.5, .5)
    @sprite.buttonMode = true
    @sprite.inputEnabled = true
    @sprite.events.onInputOut.add =>
      game.add.tween(@sprite.scale).to({x: 1, y: 1}, 200, Phaser.Easing.Linear.None, true)
    @sprite.events.onInputOver.add =>
      game.add.tween(@sprite.scale).to({x: 1.1, y: 1.1}, 200, Phaser.Easing.Linear.None, true)
    # @sprite.events.onInputDown.add =>
      # console.log('click')
    # newTower = game.add.sprite(@sprite.x, @sprite.y, 'icon-02')
    # newTower.anchor.setTo(.5, .5)
    # newTower.inputEnabled = true

    # newTower.input.enableSnap(120, 120, false, true, 55, 59);
    # @sprite.input.startDrag(game.input.activePointer)
    # newTower.events.onDragStart.add =>
      # game.add.tween(newTower.scale).to({x: 1, y: 1}, 50, Phaser.Easing.Linear.None, true)

    @sprite.input.enableDrag(true)
    @sprite.events.onDragStop.add =>
      location = _.min @locations, (loc) =>
        @sprite.position.distance(loc)
      game.add.tween(@sprite).to({x: location.x, y: location.y}, 80, Phaser.Easing.Linear.None, true)

    @structure = new AppAtk.Models.Structure()
    @waveView = new AppAtk.Views.WaveView(game, 0, 0)
    @_generateWave()

#    monster = new AppAtk.Views.Monster(game, 40, 40)
#    game.add.existing(monster)

    homeButton = document.getElementById('home-button')
    homeButton.onclick = => @_generateWave()

  update: ->

  _generateWave: ->
    wavePath = @structure.generateWavePath()
    wave = new AppAtk.Models.Wave(path: wavePath)
    @waveView.drawWave(wave)



window.game = game
