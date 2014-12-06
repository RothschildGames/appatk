class AppAtk.Models.GameState extends Backbone.Model
  defaults:
    wave: 1
    health: 100
    score: 0

  DAMAGE = 5

  initialize: ->
    @listenTo(AppAtk, 'lost-life', @_lostLife)

  _lostLife: ->
    @set('health', @get('health') - DAMAGE)
