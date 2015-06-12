
fs          = require 'fs'

gulp        = require 'gulp'
runSequence = require 'run-sequence'
util        = require 'gulp-util'
del         = require 'del'
header      = require 'gulp-header'
watch       = require 'gulp-watch'
mocha       = require 'gulp-mocha'
bump        = require 'gulp-bump'
rename      = require 'gulp-rename'

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

gulp.task 'clean', (cb) ->
  del src.js, cb

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
    .pipe(rename(extname: '.min.js'))
    .pipe(gulp.dest(dst.js))

gulp.task 'header', ->
  pkg = JSON.parse(fs.readFileSync('./package.json'))

  gulp.src(src.js)
    .pipe(header("// #{pkg.name} #{pkg.version}\n// #{pkg.repository.url}\n// #{(new Date()).toUTCString()}\n\n"))
    .pipe(gulp.dest(dst.js))

gulp.task 'watch', ->
  watch src.coffee, ->
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

gulp.task 'release', (done) ->
  runSequence 'lint', 'clean', 'coffee', 'uglify', 'bump', 'header', 'test', done

gulp.task 'default', (done) ->
  runSequence 'lint', 'clean', 'coffee', 'uglify', 'header', 'test', done
