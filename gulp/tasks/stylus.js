import gulp from 'gulp';
import nib from 'nib';

import {plumber, notify, stylus, rename} from '../plugins';
import {stylus as conf} from '../conf';

gulp.task('stylus', () => {
  return gulp.src(conf.src)
    .pipe(plumber({
      errorHandler: notify.onError('<%= error.message %>')
    }))
    .pipe(stylus({
      use: nib(),
      compress: true
    }))
    .pipe(rename({
      dirname: './'
    }))
    .pipe(gulp.dest(conf.dest, {
      cwd: './'
    }));
});

gulp.task('stylus:design', () => {
  return gulp.src(['design/src/css/main.styl'])
    .pipe(plumber({
      errorHandler: notify.onError('<%= error.message %>')
    }))
    .pipe(stylus({
      use: nib(),
      compress: true
    }))
    .pipe(rename({
      dirname: './'
    }))
    .pipe(gulp.dest('design/css', {
      cwd: './'
    }));
});
