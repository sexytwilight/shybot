config = require '../config.coffee'
Package = config 'Package'
{ FChatClient, FListClient } = require 'f-chat.io'

# bot code goes here!
fchat = new FChatClient {
  cname: "#{Package.name}<#{config 'Character'}>,f-chat.io"
  cversion: "v#{Package.version}-#{config 'Character'}"
  port: config 'port'
}

handle = (name, handler) -> (error, args...) ->
  if error
    console.log "#{name} Error: #{error?.message or error}\n#{error?.stack}"
  else
    handler? args...

fchat.on 'error', handle 'Error'

# WebSocket connection established
fchat.on 'connected', ->
  console.log 'Client connected'
  # Something caused the WebSocket to disconnect
  fchat.on 'disconnected', ->
    console.log 'Client disconnected'
  # Got API ticket from https://www.f-list.net/json/getApiTicket.php
  fchat.on 'ticket', handle 'Ticket', (data) ->
    console.log 'Requested ticket: ' + data.ticket
  # Got IDN from server, after automatically sending IDN from client
  fchat.on 'identified', handle 'Identified', (data) ->
    console.log 'Identified as character: ' + data.character
    # This apparently has a Syntax Error:
    fchat.send 'JCH', channel: 'ADH-97ab25d9295689640891'
  # fchat.on 'ICH', handle 'ICH', ({ channel }) ->
  #   fchat.send 'RST', { channel, status: 'public' }
  #   fchat.send 'CIU', { channel, character: 'Sexy Twilight' }
  # Raw commands, that got successfully parsed from any
  # message the WebSocket client got from the server

  # fchat.on 'raw', handle 'Raw', (command) ->
  #   console.log '>> [' + command.id + '] -> ' + JSON.stringify(command.args)

  # Any of the commands listed here https://wiki.f-list.net/FChat_server_commands
  # that got successfully parsed by the FChatClient object's parse(...) method
  # should trigger events with the same three-character names listed on the
  # wiki, e.g. the "PIN" command:
  fchat.on 'PIN', handle 'Ping', (args) ->
    console.log 'Recieved PING from server'
    #fchat.disconnect()

  fchat.on 'PRI', handle 'Private Message', ({ character, message }) ->
    fchat.send 'PRI', { recipient: character,  message: "um, #{message}, um.. #{character}" }

  fchat.on 'MSG', handle 'Channel Message', ({ channel, message, character }) ->
    if (new RegExp "#{config 'character'}", 'i').test message
      setTimeout ->
        fchat.send 'MSG', { channel, message: "um, #{message}, um.. #{character}" }
      , Math.random() * message.length * 17

fchat.connect (config 'Account'), (config 'Password'), {
  autoPing: yes
  character: config 'Character'
}
