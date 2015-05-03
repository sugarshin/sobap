module.exports = (gulp, {copy}) ->
  gulp.task 'copy', ->
    gulp
    .src copy.src
    .pipe gulp.dest copy.dest

  gulp.task 'copy:design', ->
    gulp
    .src ['./node_modules/octicons/octicons/octicons.{css,eot,svg,ttf,woff}']
    .pipe gulp.dest 'design'
