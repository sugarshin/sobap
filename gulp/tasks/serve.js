import gulp from 'gulp';
import browserSync from 'browser-sync';

import {design, serve} from '../conf';

gulp.task('serve:design', () => {
  browserSync(design);
});

gulp.task('serve', () => {
  browserSync(serve);
});
