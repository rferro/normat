
pkg    = require './package'

gulp        = require 'gulp'
runSequence = require 'run-sequence'
util        = require 'gulp-util'
clean       = require 'gulp-clean'
header      = require 'gulp-header'
watch       = require 'gulp-watch'
mocha       = require 'gulp-mocha'
bump        = require 'gulp-bump'

coffee     = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
sourcemaps = require 'gulp-sourcemaps'
uglify     = require 'gulp-uglify'

src =
  coffee:  'src/**/*.coffee'
  js:      'lib/**/*.js'
  version: ['component.json', 'package.json']
dst =
  js: 'lib'

gulp.task 'clean', ->
  gulp.src(src.js, read: false)
    .pipe(clean())

gulp.task 'lint', ->
  gulp.src(src.coffee)
    .pipe(coffeelint())
    .pipe(coffeelint.reporter('fail'))

gulp.task 'coffee', ->
  gulp.src(src.coffee)
    .pipe(coffee(bare: false).on('error', util.log))
    .pipe(gulp.dest(dst.js))

gulp.task 'uglify', ->
  gulp.src(src.js)
    .pipe(uglify(preserveComments: false, mangle: true, compress: false))
    .pipe(gulp.dest(dst.js))

gulp.task 'header', ->
  gulp.src(src.js)
    .pipe(header("// #{pkg.name} #{pkg.version}\n// #{pkg.repository.url}\n// #{(new Date()).toUTCString()}\n\n"))
    .pipe(gulp.dest(dst.js))

gulp.task 'watch', ->
  watch src.coffee, verbose: true, name: 'coffee', ->
    runSequence 'lint', 'coffee'

gulp.task 'bump', ->
  type = 'patch'

  if util.env.major
    type = 'major'
  else if util.env.minor
    type = 'minor'

  gulp.src(src.version)
    .pipe(bump(type: type))
    .pipe(gulp.dest('.'))

gulp.task 'test', ->
  gulp.src('test/*.coffee', read: false)
    .pipe(mocha(reporter: 'spec'))

gulp.task 'release', (cb) ->
  runSequence 'lint', 'coffee', 'uglify', 'header', 'test', cb

gulp.task 'default', (cb) ->
  runSequence 'lint', 'coffee', 'uglify', 'header', 'test', cb
