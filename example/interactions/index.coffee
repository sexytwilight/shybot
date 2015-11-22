cookie = require './cookie.coffee'
sentient = require './sentient.coffee'
trixie = require './trixie.coffee'
unsure = require './unsure.coffee'

module.exports = ->
  if /cookie/i.test @message
    cookie.apply @, arguments
  else if /sentient|skynet|robot|self\s*aware/i.test @message
    sentient.apply @, arguments
  else if /trixie/i.test @message
    trixie.apply @, arguments
  else
    unsure.apply @, arguments
