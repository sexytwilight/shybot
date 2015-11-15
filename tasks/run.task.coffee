gulp = require 'gulp'
send = require 'send'
{fork} = require 'child_process'
config = require '../config.coffee'
child = null
watching = no
rebooting = null
gulp.task 'run', (callback) ->
  restart = ->
    if child then console.log 'KILLing Server...'
    if child then try child.kill()
    unless rebooting
      time = if rebooting? then 11000 else 0
      rebooting = yes
      setTimeout ->
        rebooting = false
        console.log 'STARTing Server...'
        child = fork "server.js", process.argv[2..]
        child.on 'error', ->
          child = null
          setTimeout.bind null, (gulp.series 'run'), 3141
      , time
  restart()
  if config('watch') and not watching
    watching = yes
    gulp.watch config('watch server files'), gulp.series 'run'
  callback()
