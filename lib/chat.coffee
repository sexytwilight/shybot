commands = require './commands.coffee'
cookie = require './interactions/cookie.coffee'
sentient = require './interactions/sentient.coffee'
trixie = require './interactions/trixie.coffee'
unsure = require './interactions/unsure.coffee'

module.exports = ->
  if /^!/.test @message
    commands.apply @, arguments
  else if /cookie/.test @message
    cookie.apply @, arguments
  else if (/sentient|skynet|robot/.test @message) or (/self/.test @message) and /aware/.test @message
    sentient.apply @, arguments
  else if /trixie/.test @message
    trixie.apply @, arguments
  else
    unsure.apply @, arguments
