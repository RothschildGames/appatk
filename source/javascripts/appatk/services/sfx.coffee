class AppAtk.Sfx

  music: 'RinbackTone.ogg'

  soundsSources:
    hit: ['Jump8', 'Jump15', 'Jump17']

  sounds: {}


  constructor: (@game) ->
    for key, values of @soundsSources
      soundObjects = []
      for file, idx in values
        soundKey = "#{key}#{idx}"
        game.load.audio(soundKey, "/sfx/#{file}.wav")
        soundObjects.push soundKey
      @sounds[key] = soundObjects

    game.load.audio('bgmusic', "/sfx/#{@music}")

  start: ->
    AppAtk.on('monster-killed', (monster) =>
      @play('hit')
    )
    @game.add.audio('bgmusic', 0.25, true).play()

  play: (key) ->
    soundKey = _.sample(@sounds[key])
    @game.add.audio(soundKey).play()