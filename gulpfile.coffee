gulp = require 'gulp'
browserSync = require 'browser-sync'
runSequence = require 'run-sequence'
requireDir = require 'require-dir'
$ = require('gulp-load-plugins')()
conf = require './tasks/_conf/'

tasks = requireDir './tasks'
Object.keys(tasks).forEach (task) -> tasks[task] gulp, conf, $

reload = browserSync.reload

gulp.task 'serve', -> browserSync conf.serve

gulp.task 'start', (cb) ->
  runSequence(
    ['jade', 'stylus', 'browserify']
    'watchify'
    'serve'
    cb
  )

gulp.task 'default', ['start'], ->
  gulp.watch ["./#{conf.S.SRC}/index.jade"], ['jade', reload]
  gulp.watch ["./#{conf.S.SRC}/css/**/*.styl"], ['stylus', reload]
  gulp.watch ["./#{conf.S.DEST}/**/*.js"], reload

gulp.task 'build', (cb) ->
  runSequence(
    'clean'
    ['jade', 'stylus', 'browserify', 'copy']
    ['replace', 'minify-css', 'uglify']
    cb
  )
