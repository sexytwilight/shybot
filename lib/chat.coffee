config = require '../config.coffee'

commands = require './commands.coffee'
interactions = try require '../interactions/index.coffee'

module.exports = ->
  response = commands.apply @, arguments
  if response isnt no
    response
  else if @private or (new RegExp "#{config 'Character'}", 'i').test @message
    interactions?.call @
