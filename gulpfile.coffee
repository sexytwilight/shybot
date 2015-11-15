gulp = require 'gulp'

require './tasks/run.task.coffee'

gulp.task 'default', gulp.series 'run'
