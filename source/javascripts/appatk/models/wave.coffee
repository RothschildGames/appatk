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
      tint: 0xffffff
      scale: 1
      hp: 200
      damage: 1
      speed: 1
      loot: 1
      image: 'monster0'
    )
  },
  {
    amount: 35
    interval: 60
    monster: new AppAtk.Models.Monster(
      tint: 0xffde3f
      scale: 1.05
      hp: 300
      damage: 2
      speed: 1.1
      loot: 2
      image: 'monster1'
    )
  },
  {
    amount: 40
    interval: 55
    monster: new AppAtk.Models.Monster(
      tint: 0x7a3030
      scale: 1.1
      hp: 400
      damage: 4
      speed: 1
      loot: 3
      image: 'monster2'
    )
  },
  {
    amount: 55
    interval: 50
    monster: new AppAtk.Models.Monster(
      tint: 0x432929
      scale: 1.15
      hp: 500
      damage: 6
      speed: 1.2
      loot: 4
      image: 'monster3'
    )
  },
  {
    amount: 60
    interval: 50
    monster: new AppAtk.Models.Monster(
      tint: 0x8d4000
      scale: 1.2
      hp: 600
      damage: 8
      speed: 1.3
      loot: 5
      image: 'monster4'
    )
  }
])


