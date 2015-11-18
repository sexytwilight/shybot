fs = require 'fs'
commands = {}
loadCommands = (filename) ->
  console.log filename
  for own key, value of require filename
    if typeof value is 'function'
      name = key.toLowerCase().replace /\W+/g, ''
      console.log "  !#{name.toUpperCase()}"
      commands[name] = value
for filename in fs.readdirSync "#{__dirname}/commands/"
  if /\.command\.\w+$/.test filename
    loadCommands "#{__dirname}/commands/#{filename}"
for filename in fs.readdirSync "#{__dirname}/../commands/"
  if /\.command\.\w+$/.test filename
    loadCommands "../commands/#{filename}"
module.exports = ->
  response = ''
  @message.replace /^!(\w+)\s?(.*)$/, (match, command, args) =>
    command = commands["#{command}".toLowerCase()]
    if typeof command is 'function'
      response = command.apply @, "#{args}".split /\s*,\s*/g
    else
      console.log "COMMAND NOT FOUND: (#{@character}) #{match}"
  response
