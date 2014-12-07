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
    damage: 40
  },
  {
    name: 'Splashy'
    spriteIdx: 1
    position: 1
    cooldown: 400
    damage: 100
    radius: 200
    price: 10
  },
  {
    name: 'Slowey'
    spriteIdx: 2
    position: 2
    damage: 20
    price: 20
  },
  {
    name: 'Snipey'
    spriteIdx: 3
    position: 3
    damage: 1000
    cooldown: 1000
    radius: 400
    price: 30
  },
  ])
