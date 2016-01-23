# load the config file
config = require '../config.coffee'

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

  console.log "STATUS: #{status}, #{statusmsg}"

module.exports =
  '!status': ->
    # Make this command for owners only
    unless @character in config 'owners'
      return "PERMISSION DENIED: You are not the boss of The Great & Powerful #{config 'character'}!"

    # Strip the !command part from the chat message
    message = @message.replace /^!\w+\s/, ''

    # Default status to online
    status = 'online'
    # match the status using regexp, replace status with '' and return statusmsg
    statusmsg = message.replace /^(online|looking|busy|dnd|idle|away|crown)\s+/i,
      (match, statusMatch) ->
        # save the real status to status veriable
        status = statusMatch.toLowerCase()
        # replaces the status with nothing so that it does show up in statusmsg
        ''

    # Send status to chat server using https://wiki.f-list.net/FChat_client_commands#STA
    @send 'STA', { status, statusmsg }

    # Save status to config file
    config 'status', status
    # Save status message to config file
    config 'statusmsg', statusmsg

    # return a confirmation message:
    "Yes Great & Superior #{@character}, I will set my status."
