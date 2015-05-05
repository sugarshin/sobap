module.exports = (gulp, {minifyCss}, $) ->
  gulp.task 'minify-css', ->
    gulp
    .src minifyCss.src
    .pipe $.concat 'main.css'
    .pipe $.minifyCss()
    .pipe $.rename
      suffix: '.min'
    .pipe gulp.dest minifyCss.dest
