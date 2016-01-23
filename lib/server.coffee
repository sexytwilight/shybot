config = require '../config.coffee'
co = require 'co'

chat = require './chat.coffee'
channels = require './channels.coffee'

fchat = require './fchat.coffee'

reconnecting = null
connect = ->
  unless reconnecting
    delay = if reconnecting? then 20000 else 0
    if reconnecting?
      console.log "#{config 'Character'} is must wait before reconnecting..."
    reconnecting = true
    setTimeout ->
      reconnecting = false
      console.log "#{config 'Character'} is connecting..."
      fchat.connect (config 'Account'), (config 'Password'), {
        autoPing: yes
        character: config 'Character'
      }
    , delay

handle = require './handler.coffee'

fchat.on 'error', handle 'Error'

fchat.on 'connected', ->
  console.log "#{config 'Character'} connected to #{(config 'Host') or 'chat.f-list.net'}:#{(config 'Port') or 8799}"

  fchat.on 'disconnected', ->
    console.log "#{config 'Character'} disconnected?!"
    connect()

  fchat.var = {}
  fchat.on 'VAR', handle 'Server Variable', ({ variable, value }) ->
    fchat.var[variable] = if typeof value is 'string' then try JSON.parse value else value

  channels fchat

  fchat.on 'PRI', handle 'Private Message', (data) ->
    { character, message } = data
    co ->
      try
        message = chat.call Object.assign (Object.create fchat), data, { private: yes }
      catch error
        handle('Message') error
      if message
        console.log message
        fchat.send 'PRI', {
          recipient: character
          message
        }

  fchat.on 'MSG', handle 'Channel Message', (data) ->
    { channel, message } = data
    co ->
      try
        message = chat.call Object.assign (Object.create fchat), data
      catch error
        handle('Message') error
      if message
        console.log message
        fchat.send 'MSG', {
          channel
          message
        }

connect()
