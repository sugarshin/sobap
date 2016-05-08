import gulp from 'gulp';
import requireDir from 'require-dir';
import runSequence from 'run-sequence';
import {reload} from 'browser-sync';
import del from 'del';
import {D} from './gulp/conf';

requireDir('./gulp/tasks');

gulp.task('predesign', cb => {
  runSequence(
    ['jade:design', 'stylus:design', 'copy:design'],
    'serve:design',
    cb
  );
});

gulp.task('predefault', cb => {
  runSequence(
    ['jade', 'stylus', 'copy:octicon', 'copy:favicon'],
    'watchify',
    'serve',
    cb
  );
});

gulp.task('design', ['predesign'], () => {
  gulp.watch(
    ['./design/src/*.jade'],
    ['jade:design', reload]
  );
  gulp.watch(
    ['./design/src/css/**/*.styl'],
    ['stylus:design', reload]
  );
});

gulp.task('default', ['predefault'], () => {
  gulp.watch(
    [`./${D.SRC}/index.jade`],
    ['jade', reload]
  );
  gulp.watch(
    [`./${D.SRC}/css/**/*.styl`],
    ['stylus', reload]
  );
  gulp.watch(
    [`./${D.DEST}/**/*.js`],
    reload
  );
});

gulp.task('clean:build', () => del(['public/css/main.css', 'public/css/octicons.css', 'public/js/main.js']));

gulp.task('build', cb => {
  runSequence(
    'clean',
    ['jade', 'stylus', 'browserify', 'copy:octicon', 'copy:favicon'],
    ['replace', 'minify-css', 'uglify'],
    'clean:build',
    cb
  );
});
