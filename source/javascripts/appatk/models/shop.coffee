class AppAtk.Models.Shop extends Backbone.Model
  defaults:
    name: ''
    price: 1
    spriteIdx: 0 # sprite img
    position: 0
    cooldown: 200 # ms
    radius: 150
    damage: 10
    installationCooldown: 100 #ms


class AppAtk.Models.Shops extends Backbone.Collection
  model: AppAtk.Models.Shop


AppAtk.Models.shops = new AppAtk.Models.Shops([
  {
    name: 'Shooty'
    spriteIdx: 0
    position: 0

    price: 5
    cooldown: 100
    damage: 100
    radius: 170
  },
  {
    name: 'Slowey'
    spriteIdx: 2
    position: 2

    price: 20
    cooldown: 100
    damage: 50
    radius: 120
  },
  {
    name: 'Splashy'
    spriteIdx: 1
    position: 1

    price: 12
    cooldown: 600
    damage: 200
    radius: 180
  },
  {
    name: 'Snipey'
    spriteIdx: 3
    position: 3

    price: 35
    cooldown: 750
    damage: 1000
    radius: 400
  },
  ])
