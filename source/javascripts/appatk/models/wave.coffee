class AppAtk.Models.Wave extends Backbone.Model
  defaults:
    path: null
    amount: 20
    interval: 20
    monster: null

AppAtk.Models.waves = new Backbone.Collection([
  {
    amount: 30
    interval: 65
    monster: new AppAtk.Models.Monster(
      tint: 0xffff00
      scale: 1
      hp: 1
      damage: 1
      speed: 1
      loot: 1
    )
  },
  {
    amount: 35
    interval: 60
    monster: new AppAtk.Models.Monster(
      tint: 0xfF991F
      scale: 1.05
      hp: 2
      damage: 2
      speed: 1.1
      loot: 2
    )
  },
  {
    amount: 40
    interval: 55
    monster: new AppAtk.Models.Monster(
      tint: 0x884400
      scale: 1.1
      hp: 3
      damage: 4
      speed: 1
      loot: 3
    )
  },
  {
    amount: 55
    interval: 50
    monster: new AppAtk.Models.Monster(
      tint: 0xffffaa
      scale: 1.15
      hp: 4
      damage: 6
      speed: 1.2
      loot: 4
    )
  },
  {
    amount: 60
    interval: 50
    monster: new AppAtk.Models.Monster(
      tint: 0x333333
      scale: 1.2
      hp: 5
      damage: 8
      speed: 1.3
      loot: 5
    )
  }
])


