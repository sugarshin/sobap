nib = require 'nib'

module.exports = (gulp, {stylus}, $) ->
  gulp.task 'stylus', ->
    gulp
    .src stylus.src
    .pipe $.plumber
      errorHandler: $.notify.onError '<%= error.message %>'
    .pipe $.stylus
      use: nib()
      compress: true
    .pipe $.rename dirname: './'
    .pipe gulp.dest stylus.dest,
      cwd: './'

  gulp.task 'stylus:design', ->
    gulp
    .src ['design/src/css/main.styl']
    .pipe $.plumber
      errorHandler: $.notify.onError '<%= error.message %>'
    .pipe $.stylus
      use: nib()
      compress: true
    .pipe $.rename dirname: './'
    .pipe gulp.dest 'design/css',
      cwd: './'
