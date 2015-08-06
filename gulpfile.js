var gulp = require('gulp');

gulp.task('default', function() {
  return gulp.src('./bower_components/knockoutjs/dist/knockout.debug.js')
    .pipe(gulp.dest('./scripts'));
});
