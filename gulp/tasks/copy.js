import gulp from 'gulp';

import {D} from '../conf';

gulp.task('copy:octicon', () => {
  return gulp.src(['./node_modules/octicons/octicons/octicons.{css,eot,svg,ttf,woff}'])
    .pipe(gulp.dest(`${D.DEST}/css`));
});

gulp.task('copy:design', () => {
  return gulp.src(['./node_modules/octicons/octicons/octicons.{css,eot,svg,ttf,woff}'])
    .pipe(gulp.dest('design'));
});

gulp.task('copy:favicon', () => {
  return gulp.src(['./src/img/favicon.ico'])
    .pipe(gulp.dest(D.DEST));
});
