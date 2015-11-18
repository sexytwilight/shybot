fs = require 'fs'

escapeRegExp = (string) ->
  string.replace /[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&"

strip = (key) ->
  key.toLowerCase().replace /[\s_]+/g, '_'

commands = {}
loadCommands = (filename) ->
  console.log filename
  for own key, value of require filename
    if typeof value is 'function'
      name = strip key
      console.log "  #{name}(#{value.length or 0})"
      commands[name] = value

# for filename in fs.readdirSync "#{__dirname}/commands/"
#   if /\.command\.\w+$/.test filename
#     loadCommands "#{__dirname}/commands/#{filename}"
for filename in fs.readdirSync "#{__dirname}/../commands/"
  if /\.command\.\w+$/.test filename
    loadCommands "../commands/#{filename}"

findCommand = new RegExp "^(#{
  Object.keys commands
    .map (key) ->
      escapeRegExp key
        .replace /_/g, '[\\s_]+'
    .join '|'
})\s*(.*)\s*$", 'i'

module.exports = ->
  response = no
  @message.replace findCommand, (match, command, args) =>
    command = commands[strip "#{command}"]
    args = "#{args or ''}".replace /^\s+|\s+$/g, ''
    if typeof command is 'function'
      response = command.apply @, "#{args}".split /\s*,\s*/g
  response
