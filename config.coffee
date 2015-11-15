{argv} = require 'yargs'
path = require 'path'
pack = require './package.json'
CSON = require 'require-cson'
fs = require 'fs'

configFile = try require argv.config
configFilePath = argv.config
unless configFile
  configFile = try require process.env.config
  configFilePath = process.env.config
unless configFile
  configFile = {}
  configFilePath = ''

Config = (key, value) ->
  if arguments.length > 1
    config[strip key] = value
    configFile[key] = value
    if configFilePath
      fs.write configFilePath, CSON.stringify configFile
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
