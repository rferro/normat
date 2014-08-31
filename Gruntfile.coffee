
module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
    bumpup:
      options:
        updateProps:
          pkg: 'package.json'
      files: ['package.json', 'component.json']
    coffee:
      make:
        options:
          bare: false
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
      make:
        options:
          report:           false
          preserveComments: false
          banner:           '// <%= pkg.name %> <%= pkg.version %>\n// <%= pkg.repository.url %>\n// <%= grunt.template.today("yyyy-mm-dd HH:MM:ss Z") %>\n\n'
          mangle:           true
          compress:         false
          beautify:         false
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
      files: ['src/**/*.coffee']
      tasks: ['coffee', 'uglify']
    mochaTest:
      options:
        reporter: 'spec'
        require: 'coffee-script/register'
      src: ['test/**/*.coffee']
  )

  grunt.registerTask 'release', (type = 'patch') ->
    grunt.task.run 'bumpup:' + type
    grunt.task.run 'coffee'
    grunt.task.run 'uglify'

  grunt.registerTask 'test', ->
    grunt.task.run 'mochaTest'
