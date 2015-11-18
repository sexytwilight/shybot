fs = require 'fs'
commands = {}
for commandsFilename in fs.readdirSync "#{__dirname}/commands/"
  if /\.command\.\w+$/.test commandsFilename
    console.log commandsFilename
    for own key, value of require "./commands/#{commandsFilename}"
      if typeof value is 'function'
        name = key.toLowerCase().replace /\W+/g, ''
        console.log "  !#{name.toUpperCase()}"
        commands[name] = value
module.exports = ->
  response = ''
  @message.replace /^!(\w+)\s?(.*)$/, (match, command, args) =>
    command = commands["#{command}".toLowerCase()]
    if typeof command is 'function'
      response = command.apply @, "#{args}".split /\s*,\s*/g
    else
      console.log "COMMAND NOT FOUND: (#{@character}) #{match}"
  response
