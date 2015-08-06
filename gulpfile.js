var gulp = require('gulp');

gulp.task('default', function() {
  return gulp.src('./bower_components/knockout-secure-binding/dist/knockout-secure-binding.js')
    .pipe(gulp.dest('./lib'));
});
