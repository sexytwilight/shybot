config = require '../config.coffee'
co = require 'co'

chat = require './chat.coffee'
rooms = require './rooms.coffee'

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

  rooms fchat

  fchat.on 'PRI', handle 'Private Message', (data) ->
    { character, message } = data
    began = Date.now()
    co ->
      message = chat.call Object.assign (Object.create fchat), data, { character: 'you' }
      if message
        console.log message
        setTimeout ->
          fchat.send 'PRI', {
            recipient: character
            message
          }
        , Math.abs(((message.split /\W+/g).length * 351) - (Date.now() - began))

  fchat.on 'MSG', handle 'Channel Message', (data) ->
    { channel, message } = data
    if (/^!/.test message) or (new RegExp "#{config 'Character'}", 'i').test message
      began = Date.now()
      co ->
        console.log data
        message = chat.call Object.assign (Object.create fchat), data
        if message
          console.log message
          setTimeout ->
            fchat.send 'MSG', {
              channel
              message
            }
          , Math.abs(((message.split /\W+/g).length * 351) - (Date.now() - began))

connect()
