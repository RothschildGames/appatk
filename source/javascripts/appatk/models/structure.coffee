class AppAtk.Models.Structure

  constructor: (@width = 4, @height = 6) ->
    @towersMatrix = @_generateMatrix(@width, @height)
    @pathsMatrix = @_generateMatrix(@width - 1, @height + 1)

  generateWavePath: ->
    wavePath = []
    nextCol = Math.floor(Math.random() * (@width - 1))
    _.times(@height + 1, (row) =>
      col = nextCol
      wavePath.push(new Phaser.Point(col, row))
      if row != @height && row != 0
        nextCol = Math.floor(Math.random() * (@width - 1))
        wavePath.push(new Phaser.Point(nextCol, row))
    )
    wavePath

  hasTowerAt: (row, col) ->
    @towersMatrix[row][col] != null

  addTowerAt: (tower, row, col) ->
    @towersMatrix[row][col] = tower

  removeTowerAt: (row, col) ->
    @towersMatrix[row][col] = null

  _generateMatrix: (width, height) ->
    towersMatrix = []
    _.times(height, ->
      row = []
      _.times(width, -> row.push(null))
      towersMatrix.push(row)
    )
    towersMatrix
