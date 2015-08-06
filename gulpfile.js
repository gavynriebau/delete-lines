var gulp = require('gulp');

gulp.task('copy-knockout', function() {
  return gulp.src('./bower_components/knockoutjs/dist/knockout.debug.js')
    .pipe(gulp.dest('./lib'));
});

gulp.task('copy-knockout-secure-bindings', function() {
  return gulp.src('./bower_components/knockout-secure-binding/dist/knockout-secure-binding.js')
    .pipe(gulp.dest('./lib'));
});

gulp.task('default', ['copy-knockout', 'copy-knockout-secure-bindings']);
