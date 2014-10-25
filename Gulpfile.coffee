gulp       = require 'gulp'
gutil      = require 'gulp-util'
nodemon    = require 'gulp-nodemon'
browserify = require 'browserify'
source     = require 'vinyl-source-stream'
watchify   = require 'watchify'
streamify  = require 'gulp-streamify'
uglify     = require 'gulp-uglify'
bower      = require 'gulp-bower'
sass       = require 'gulp-sass'
rename     = require 'gulp-rename'

config =
  buildDir: 'assets'
  src : 'src/'
  bowerDir : 'bower_components'

getBundle = ->
  browserify({ debug:true, cache: {}, packageCache: {}, fullPaths: true})
  .add('./src/scripts/app.coffee')
  .transform( 'coffeeify')

gulp.task "watch-scripts", ->
  bundler = watchify getBundle()

  updater = (b) ->
    bundler.bundle()
    .pipe source("bundle.js")
    .pipe gulp.dest(config.buildDir)

  timer = (time) ->
    gutil.log 'Bundle update. Elapsed time:', gutil.colors.cyan(time), 'ms'

  bundler.on 'update', updater
  bundler.on 'time', timer

  updater()

gulp.task "bower", ->
  bower()
  .pipe gulp.dest('bower_components')

gulp.task "styles", ->
  gulp.src('./src/styles/main.scss')
  .pipe sass({includePaths: [config.bowerDir]})
  .pipe rename("style.css")
  .pipe gulp.dest('./assets/')


gulp.task "production", ->
  getBundle()
  .bundle()
  .pipe source("bundle.js")
  .pipe streamify(uglify())
  .pipe gulp.dest('assets')

gulp.task 'watch-styles', ->
  gulp.watch 'src/styles/*.scss', ['styles']

gulp.task "server", ->
  nodemon(
    script: "server.coffee"
    ext: "coffee"
    ignore: [
      "assets/*"
      "**/node_modules/**/*"
    ]
  )

gulp.task 'default', ['server','watch-scripts', 'styles','watch-styles']