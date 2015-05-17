module.exports = (gulp, conf) ->
  gulp.task 'copy:octicon', ->
    gulp
    .src ['./node_modules/octicons/octicons/octicons.{css,eot,svg,ttf,woff}']
    .pipe gulp.dest "#{conf.D.DEST}/css"

  gulp.task 'copy:design', ->
    gulp
    .src ['./node_modules/octicons/octicons/octicons.{css,eot,svg,ttf,woff}']
    .pipe gulp.dest 'design'

  gulp.task 'copy:favicon', ->
    gulp
    .src ['./src/img/favicon.ico']
    .pipe gulp.dest 'public'
