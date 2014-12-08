class AppAtk.Loader

  preload: ->
    @_createLoadingUI()
    @_loadGameAssets()

  _createLoadingUI: ->
    bg = @add.sprite(0, 0, 'loading-background')

    text = @add.text(@world.centerX, 207, '0%')
    text.anchor.setTo(0.5, 0.5)
    text.align = 'center'
    text.font = 'Helvetica Neue'
    text.fontSize = 175
    text.fontWeight = 100
    text.fill = '#FFFFFF'

    slideText = @add.text(@world.centerX, 1170, '> click to start')
    slideText.anchor.setTo(0.5, 0.5)
    slideText.alpha = 0
    slideText.font = 'Helvetica Neue'
    slideText.fontSize = 48
    slideText.fontWeight = 200
    slideText.fill = '#FFFFFF'
    slideText.inputEnabled = true
    slideText.events.onInputDown.add =>
      if slideText.alpha > 0
        game.state.start('game')

    @load.onFileComplete.add =>
      text.text = "#{@load.progress}%"

    @load.onLoadComplete.add =>
      @add.tween(slideText).to({alpha: 0.8}, 200).start()

  _loadGameAssets: ->
    @load.image('background', 'images/bg.png')
    @load.image('death-particle', 'images/death-particle.png')
    @load.spritesheet('monster', 'images/monster.png', 42, 33)
    @load.image('battery', 'images/battery.png')
    @load.image('dead-battery', 'images/dead-battery.png')
    @load.spritesheet('apps', 'images/apps.png' ,120, 119)
    AppAtk.sfx = new AppAtk.Sfx(@)