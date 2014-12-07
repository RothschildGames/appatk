class AppAtk.Models.Shop extends Backbone.Model
  default:
    name: ''
    price: 1
    spriteIdx: 0 # sprite img
    position: 0
    cooldown: 200 # ms


class AppAtk.Models.Shops extends Backbone.Collection
  model: AppAtk.Models.Shop


AppAtk.Models.shops = new AppAtk.Models.Shops([
  {
    name: 'Shooty'
    spriteIdx: 0
    position: 0
    price: 5
  },
  {
    name: 'Splashy'
    spriteIdx: 1
    position: 1
    price: 10
  },
  {
    name: 'Slowey'
    spriteIdx: 2
    position: 2
    price: 20
  },
  {
    name: 'Snipey'
    spriteIdx: 3
    position: 3
    price: 30
  },
  ])
