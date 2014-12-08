class AppAtk.Sfx

  music: 'RinbackTone.ogg'

  soundsSources:
    hit: ['Jump8', 'Jump15', 'Jump17']
    killMonster: ['Pickup_Coin31', 'Pickup_Coin34', 'Pickup_Coin39', 'Pickup_Coin40', 'Pickup_Coin43']
    loseHealth: ['Hit_Hurt15', 'Hit_Hurt16', 'Hit_Hurt17', 'Hit_Hurt20', 'Hit_Hurt28']
  sounds: {}

  constructor: (@game) ->
    for key, values of @soundsSources
      soundObjects = []
      for file, idx in values
        soundKey = "#{key}#{idx}"
        game.load.audio(soundKey, "sfx/#{file}.wav")
        soundObjects.push soundKey
      @sounds[key] = soundObjects

    game.load.audio('bgmusic', "sfx/#{@music}")

  start: ->
    AppAtk.on('monster-killed', (monster) => @play('killMonster') )
    AppAtk.on('lost-life', => @play('loseHealth') )
    @game.add.audio('bgmusic', 0.25, true).play()

  play: (key) ->
    soundKey = _.sample(@sounds[key])
    @game.add.audio(soundKey).play()