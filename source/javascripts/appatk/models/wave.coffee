class AppAtk.Models.Wave extends Backbone.Model
  defaults:
    path: null
    amount: 20
    interval: 20
    monster: null

AppAtk.Models.waves = new Backbone.Collection([
  {
    amount: 2000
    interval: 35
    monster: new AppAtk.Models.Monster(
      tint: 0xfffff0
      scale: 1
      hp: 5
      damage: 5
      speed: 1
    )
  },
  {
    amount: 30
    interval: 18
    monster: new AppAtk.Models.Monster(
      tint: null
      scale: 1
      hp: 5
      damage: 5
      speed: 5
    )
  },
  {
    amount: 30
    interval: 16
    monster: new AppAtk.Models.Monster(
      tint: null
      scale: 1
      hp: 5
      damage: 5
      speed: 5
    )
  },
  {
    amount: 40
    interval: 14
    monster: new AppAtk.Models.Monster(
      tint: null
      scale: 1
      hp: 5
      damage: 5
      speed: 5
    )
  }
])


