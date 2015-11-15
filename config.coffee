{argv} = require 'yargs'
path = require 'path'
require 'require-cson'

configFile = try require argv.config
configFile or= try require process.env.config
configFile or= {}

Get = (key) -> config[strip key]
config = Get.config = {}
strip = Get.strip = (key) ->
  "#{key}".replace(/[\W_]+/g,'').toLowerCase()

for own key, value of process.env
  config[strip key] = value

for own key, value of configFile
  config[strip key] = value

for own key, value of argv
  config[strip key] = value

config.projectpath = path.resolve config.projectpath or process.cwd()

config.watchserverfiles or= [
  "**/*.coffee"
  "**/*.cson"
  "!node_modules/*"
]

module.exports = Get
