handle = require './handler.coffee'
config = require '../config.coffee'

module.exports = (fchat) ->
  fchat.channels or= {}
  fchat.isOp = (channel, who) ->
    oplist = (op.toLowerCase() for op in @channels?[channel]?.oplist or [])
    "#{who}".toLowerCase() in oplist
  # Notify about channel joining:
  fchat.on 'ICH', handle 'Initial Channel Data', ({ channel, users, mode }) ->
    channel = fchat.channels[channel] or= { id: channel }
    channel.users or= {}
    channel.mode = mode
    for user in users
      channel.users[user.identity] or= user
  fchat.on 'JCH', handle 'Join Channel', ({ channel, character, title }) ->
    channel = fchat.channels[channel] or= { id: channel }
    channel.title = title
    channel.users or= {}
    channel.users[character] or= identity: character
  fchat.on 'COL', handle 'Channel Ops', ({ channel, oplist }) ->
    channel = fchat.channels[channel] or= { id: channel }
    channel.oplist = oplist
  # Joins all the channels in the config:
  fchat.on 'identified', handle 'Identified', ->
    blacklist = (config 'Channel Blacklist') or []
    for channel in (config 'Channels') or []
      unless channel in blacklist
        fchat.send 'JCH', {channel}
  # Recieved a channel invite:
  fchat.on 'CIU', handle 'Invitation To Channel', ({ sender, title, name }) ->
    channels = (config 'Channels') or []
    blacklist = (config 'Channel Blacklist') or []
    if name in channels
      console.log "#{sender}, I'm already in #{title}, silly!"
      fchat.send 'PRI', {
        recipient: sender
        message: "I'm already in #{title}, silly!"
      }
    else if name in blacklist
      console.log "#{sender}, I'm not supposed to join #{title}, I have been kicked/banned from there!"
      fchat.send 'PRI', {
        recipient: sender
        message: "I'm not supposed to join #{title}, I have been kicked/banned from there!"
      }
    else
      channels.push name
      fchat.send 'JCH', channel: name
      config 'Channels', channels
  # kicked/banned will auto blacklist channel:
  removeChannel = (name) ->
    channels = (config 'Channels') or []
    config 'Channels', (channel for channel in channels when channel isnt name)
  fchat.on 'CKU', handle 'Kicked From Channel', ({ character, channel }) ->
    if "#{character}".toLowerCase() is "#{config 'Character'}".toLowerCase()
      console.log "#{config 'Character'} was kicked from #{channel}"
      removeChannel channel
  fchat.on 'CBU', handle 'Banned From Channel', ({ character, channel }) ->
    if "#{character}".toLowerCase() is "#{config 'Character'}".toLowerCase()
      console.log "#{config 'Character'} was BANNED from #{channel}"
      removeChannel channel
      blacklist = (config 'Channel Blacklist') or []
      unless channel in blacklist
        blacklist.push channel
        config 'Channel Blacklist', blacklist
