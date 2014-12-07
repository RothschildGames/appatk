class AppAtk.Models.Structure extends Backbone.Model

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
    @_sanitizedPath(wavePath)

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

  _sanitizedPath: (path) ->
    newPath = []
    index = 0
    lastPoint = null
    while index < path.length
      currentPoint = path[index]
      nextPoint = path[index + 1]
      if !lastPoint || !nextPoint || (lastPoint.x == currentPoint.x && nextPoint.x != currentPoint.x) || (lastPoint.x != currentPoint.x)
        newPath.push(currentPoint)
      lastPoint = currentPoint
      index += 1

    newPath