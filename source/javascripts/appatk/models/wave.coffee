class AppAtk.Models.Wave extends Backbone.Model
  defaults:
    path: null
    amount: 20
    interval: 20
    monster: null

AppAtk.Models.waves = new Backbone.Collection([
  {
    amount: 20
    interval: 35
    monster: new AppAtk.Models.Monster(
      tint: 0xffff00
      scale: 1
      hp: 5
      damage: 5
      speed: 1
      loot: 1
    )
  },
  {
    amount: 25
    interval: 33
    monster: new AppAtk.Models.Monster(
      tint: 0xfffff0
      scale: 1
      hp: 5
      damage: 5
      speed: 1
      loot: 2
    )
  },
  {
    amount: 30
    interval: 31
    monster: new AppAtk.Models.Monster(
      tint: 0xfffff0
      scale: 1
      hp: 5
      damage: 5
      speed: 1
      loot: 3
    )
  },
  {
    amount: 35
    interval: 29
    monster: new AppAtk.Models.Monster(
      tint: 0xfffff0
      scale: 1
      hp: 5
      damage: 5
      speed: 1
      loot: 4
    )
  }
])


