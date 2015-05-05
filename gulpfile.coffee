gulp = require 'gulp'
browserSync = require 'browser-sync'
runSequence = require 'run-sequence'
requireDir = require 'require-dir'
$ = require('gulp-load-plugins')()
conf = require './gulp/conf'

tasks = requireDir './gulp/tasks'
Object.keys(tasks).forEach (name) -> tasks[name] gulp, conf, $

reload = browserSync.reload



gulp.task 'serve:design', -> browserSync conf.design

gulp.task 'predesign', (cb) ->
  runSequence(
    ['jade:design', 'stylus:design', 'copy:design']
    'serve:design'
    cb
  )

gulp.task 'design', ['predesign'], ->
  gulp.watch ['./design/src/*.jade'], ['jade:design', reload]
  gulp.watch ['./design/src/css/**/*.styl'], ['stylus:design', reload]



gulp.task 'serve', -> browserSync conf.serve

gulp.task 'prestart', (cb) ->
  runSequence(
    ['jade', 'stylus', 'browserify']
    'watchify'
    'serve'
    cb
  )

gulp.task 'default', ['prestart'], ->
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
