class AppAtk.Models.GameState extends Backbone.Model
  defaults:
    wave: 1
    health: 100
    gold: 10

  initialize: ->
    @listenTo(AppAtk, 'lost-life', @_lostLife)
    @listenTo(AppAtk, 'monster-killed', @_gotLoot)
    @listenTo(AppAtk, 'installed-tower', @_installedTower)

  waveUp: ->
    @set('wave', @get('wave') + 1)

  _lostLife: (damage) ->
    @set('health', @get('health') - damage)

  _gotLoot: (loot) ->
    @set('gold', @get('gold') + loot)

  _installedTower: (tower) ->
    @set('gold', @get('gold') - tower.get('price'))
