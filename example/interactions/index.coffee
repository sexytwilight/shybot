cookie = require './cookie.coffee'
sentient = require './sentient.coffee'
trixie = require './trixie.coffee'
unsure = require './unsure.coffee'

module.exports = ->
  if /cookie/.test @message
    cookie.apply @, arguments
  else if (/sentient|skynet|robot/.test @message) or (/self/.test @message) and /aware/.test @message
    sentient.apply @, arguments
  else if /trixie/.test @message
    trixie.apply @, arguments
  else
    unsure.apply @, arguments
