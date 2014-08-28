
module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
    coffee:
      options:
        bare: false
      process:
        files: [
          {
            expand: true
            cwd:    'src'
            src:    '**/*.coffee'
            dest:   'lib'
            ext:    '.js'
          }
        ]
    uglify:
      options:
        report:           false
        preserveComments: false
        banner:           '// <%= pkg.name %> <%= pkg.version %>\n// <%= pkg.repository.url %>\n// <%= grunt.template.today("yyyy-mm-dd HH:MM:ss Z") %>\n\n'
      process:
        options:
          mangle:   true
          compress: false
          beautify: false
        files: [
          {
            expand: true
            cwd:    'lib'
            src:    ['**/*.js']
            dest:   'lib'
            ext:    '.min.js'
          }
        ]
    watch:
      process:
        files: ['src/**/*.coffee']
        tasks: ['coffee:process']
    mochaTest:
      process:
        options:
          reporter: 'spec'
          require: 'coffee-script/register'
        src: ['test/**/*.coffee']
  )

  grunt.registerTask(
    'make'
    [
      'coffee:process'
      'uglify:process'
    ]
  )

  grunt.registerTask(
    'test'
    [
      'mochaTest:process'
    ]
  )
