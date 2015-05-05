module.exports = (gulp, {jade}, $) ->
  gulp.task 'jade', ->
    gulp
    .src jade.src
    .pipe $.plumber
      errorHandler: $.notify.onError '<%= error.message %>'
    .pipe $.jade()
    .pipe $.rename (path) -> path.dirname = path.dirname.replace 'html', '.'
    .pipe gulp.dest jade.dest

  gulp.task 'jade:design', ->
    gulp
    .src ['design/src/*.jade']
    .pipe $.plumber
      errorHandler: $.notify.onError '<%= error.message %>'
    .pipe $.jade()
    .pipe $.rename (path) -> path.dirname = path.dirname.replace 'html', '.'
    .pipe gulp.dest 'design'
