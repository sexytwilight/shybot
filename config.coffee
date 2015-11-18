{argv} = require 'yargs'
path = require 'path'
pack = require './package.json'
CSON = require 'require-cson'
fs = require 'fs'

configFilePath = path.resolve argv.config
configFile = try require argv.config
unless configFile
  configFilePath = path.resolve process.env.config
  configFile = try require process.env.config
unless configFile
  configFilePath = ''
  configFile = {}

if configFilePath
  console.log "LOADED: #{configFilePath}"
  # fs.watch configFilePath, ->
  #   fs.writeFile configFilePath, (error, data) ->
  #     if error then throw error
  #     configFile = CSON.parse data
  #     for own key, value of configFile
  #       config[strip key] = value
  #     console.log "RELOADED: #{configFilePath}"

Config = (key, value) ->
  if arguments.length > 1
    config[strip key] = value
    configFile[strip key] = value
    if configFilePath
      fs.writeFile configFilePath, CSON.stringify configFile, null, 2
  else
    config[strip key]
config = Config.config = {}
strip = Config.strip = (key) ->
  "#{key}".replace(/[\W_]+/g,'').toLowerCase()

for own key, value of process.env
  config[strip key] = value

for own key, value of configFile
  config[strip key] = value

for own key, value of argv
  config[strip key] = value

config.watchserverfiles or= [
  "**/*.coffee"
  "**/*.cson"
  "!node_modules/*"
]

config.package = pack

module.exports = Config
