class AppAtk.Models.GameState extends Backbone.Model
  defaults:
    wave: 1
    health: 100
    gold: 0

  initialize: ->
    @listenTo(AppAtk, 'lost-life', @_lostLife)
    @listenTo(AppAtk, 'got-loot', @_gotLoot)

  waveUp: ->
    @set('wave', @get('wave') + 1)

  _lostLife: (damage) ->
    @set('health', @get('health') - damage)

  _gotLoot: (loot) ->
    @set('gold', @get('gold') + loot)
