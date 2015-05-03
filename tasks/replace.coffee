# todo
module.exports = (gulp, {replace}, $) ->
  gulp.task 'replace', ->
    gulp
    .src replace.src
    .pipe $.replace replace.replacements[0][0], replace.replacements[0][1]
    .pipe $.replace replace.replacements[1][0], replace.replacements[1][1]
    .pipe $.replace replace.replacements[2][0], replace.replacements[2][1]
    .pipe gulp.dest replace.dest
