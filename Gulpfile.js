var gulp         = require('gulp'),
    glob         = require('glob'),
    isProduction = false,
    $            = require('gulp-load-plugins')();

var globs = {
    js: 'www-src/js/**/*.js',
    html: 'www-src/*.html',
    images: 'www-src/img/**',
    misc: 'www-src/**/*.{ico,eot,woff,ttf,php}'
};

gulp.task('css', function() {
    gulp.src('www-src/css/style.scss')
        .pipe($.rubySass({ 'sourcemap=none': true }))
        .pipe($.autoprefixer())
        .pipe($.if(isProduction, $.uncss({ html: glob.sync(globs.html) })))
        .pipe($.if(isProduction, $.minifyCss()))
        .pipe(gulp.dest('www/css'));
});
gulp.task('js', function () {
    gulp.src(globs.js)
        .pipe($.concat('script.js'))
        .pipe($.if(isProduction, $.uglify()))
        .pipe(gulp.dest('www/js'));
});
gulp.task('html', function() {
    gulp.src(globs.html)
        .pipe($.if(isProduction, $.htmlmin({ collapseWhitespace: true })))
        .pipe(gulp.dest('www'));
});
gulp.task('images', function() {
    gulp.src(globs.images)
        .pipe($.if(isProduction, $.imagemin({
            progressive: true
        })))
        .pipe(gulp.dest('www/img'));
});
gulp.task('misc', function () {
    gulp.src(globs.misc).pipe(gulp.dest('www'));
});

gulp.task('setProduction', function() {
    isProduction = true;
});

gulp.task('dist', ['setProduction', 'default']);
gulp.task('default', ['html', 'js', 'css', 'images', 'misc']);
