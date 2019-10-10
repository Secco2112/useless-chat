"use strict";

// Load plugins
const autoprefixer = require("autoprefixer");
const browsersync = require("browser-sync").create();
const cssnano = require("cssnano");
const gulp = require("gulp");
const plumber = require("gulp-plumber");
const postcss = require("gulp-postcss");
const rename = require("gulp-rename");
const sass = require("gulp-sass");
const del = require('del');

// BrowserSync
function browserSync(done) {
  browsersync.init({
    server: {
      baseDir: "public"
    },
    port: 8000
  });
  done();
}

function clean() {
    return del(["./_site/assets/"]);
  }

// BrowserSync Reload
function browserSyncReload(done) {
  browsersync.reload();
  done();
}

// CSS task
function css() {
  return gulp
    .src("resources/sass/main.scss")
    .pipe(plumber())
    .pipe(sass({ outputStyle: "expanded" }))
    .pipe(gulp.dest("public/css"))
    .pipe(rename({ suffix: ".min" }))
    .pipe(postcss([autoprefixer(), cssnano()]))
    .pipe(gulp.dest("public/css"))
    .pipe(browsersync.stream());
}

// Watch files
function watchFiles() {
  gulp.watch("resources/sass/main.scss", css);
}

// define complex tasks
const build = gulp.series(clean, gulp.parallel(css));
const watch = gulp.parallel(watchFiles, browserSync);

// export tasks
exports.css = css;
exports.build = build;
exports.watch = watch;
exports.default = build;