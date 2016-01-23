# load the config file
config = require '../config.coffee'

# setTimeout hack to wait for fchat client module to initialize before we require it
setTimeout ->
  # get the fchat client
  fchat = require '../lib/fchat.coffee'
  # wait for fchat client to connect to fchat server and for f-chat to send identity
  fchat.on 'IDN', ->
    # get the status from the config file
    status = config 'status'
    # if no status valid saved, default to
    unless /^(online|looking|busy|dnd|idle|away|crown)$/.test status then status = 'online'
    # get the status message from the config file
    statusmsg = config 'statusmsg'
    # if no status saved, default to
    statusmsg or= "#{config 'character'} is ONLINE!"
    # send the saved status message to the server
    fchat.send 'STA', { status, statusmsg }

    console.log "#{status}, #{statusmsg}"

module.exports =
  '!status': ->
    # Make this command for owners only
    unless @character in config 'owners'
      return "PERMISSION DENIED: You are not the boss of The Great & Powerful #{config 'character'}!"

    # Strip the !command part from the chat message
    message = @message.replace /^!\w+\s/, ''

    # Default status to online
    status = 'online'
    # Remove the status from the message and save to status veriable
    statusmsg = message.replace /^(online|looking|busy|dnd|idle|away|crown)\s+/i, (match, statusMatch) -> status = statusMatch.toLowerCase()

    # Send status to chat server using https://wiki.f-list.net/FChat_client_commands#STA
    @send 'STA', { status, statusmsg }

    # Save status message to config file
    config 'status', status

    # return a confirmation message:
    "Yes Great & Superior #{@character}, I will set my status."
