config = require '../config.coffee'
Package = config 'Package'

{ FChatClient } = require 'f-chat.io'

fchat = new FChatClient {
  cname: "#{Package.name}<#{config 'Character'}>,f-chat.io"
  cversion: "v#{Package.version}-#{config 'Character'}"
  port: config 'Port'
}

# Dirty hack bypass until fchat.io is fixed....
fchat.send = (command, params, cb) ->
  @socket.send("#{command} #{JSON.stringify params}", cb);

module.exports = fchat
