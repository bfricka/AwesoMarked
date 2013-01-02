testacular = require("testacular")

#global module:false
module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-recess"
  grunt.loadNpmTasks "grunt-coffee"

  # Project configuration.
  grunt.initConfig
    builddir: "build"
    pkg: "<json:package.json>"
    meta:
      banner: "/**\n" +
      " * <%= pkg.description %>\n" +
      " * @version v<%= pkg.version %> - " +
      "<%= grunt.template.today(\"yyyy-mm-dd\") %>\n" +
      " * @link <%= pkg.homepage %>\n" +
      " * @license MIT License, http://www.opensource.org/licenses/MIT\n" +
      " */"

    coffee:
      build:
        src: ["common/*.coffee", "modules/**/*.coffee"]
        extension: ".coffee.js"

    concat:
      build:
        src: ["<banner:meta.banner>", "common/*.js"]
        dest: "<%= builddir %>/<%= pkg.name %>.js"

    min:
      build:
        src: ["<banner:meta.banner>", "<config:concat.build.dest>"]
        dest: "<%= builddir %>/<%= pkg.name %>.min.js"

    recess:
      build:
        src: ["common/**/*.less"]
        dest: "<%= builddir %>/<%= pkg.name %>.css"
        options:
          compile: true

      min:
        src: "<config:recess.build.dest>"
        dest: "<%= builddir %>/<%= pkg.name %>.min.css"
        options:
          compress: true

    lint:
      files: ["grunt.js", "js/**/*.js"]

    watch:
      files: ["app/**/*.coffee", "app/**/*.js"]
      tasks: "coffee build test"


  # Default task.
  grunt.registerTask "default", "coffee build test"
  grunt.registerTask "build", "build all of AwesoMarked", ->
    jsBuildFiles = grunt.config("concat.build.src")
    lessBuildFiles = []
    if @args.length > 0
      @args.forEach (moduleName) ->
        modulejs = grunt.file.expandFiles("modules/*/" + moduleName + "/*.js")
        moduleless = grunt.file.expandFiles("modules/*/" + moduleName + "/stylesheets/*.less", "modules/*/" + moduleName + "/*.less")
        jsBuildFiles = jsBuildFiles.concat(modulejs)
        lessBuildFiles = lessBuildFiles.concat(moduleless)


      #Set config with our new file lists
      grunt.config "builddir", "build/custom"
      grunt.config "concat.build.src", jsBuildFiles
      grunt.config "recess.build.src", lessBuildFiles
    else
      grunt.config "concat.build.src", jsBuildFiles.concat(["modules/*/*/*.js"])
      grunt.config "recess.build.src", lessBuildFiles.concat(grunt.config("recess.build.src"))
    grunt.task.run "concat min recess:build recess:min"

  grunt.registerTask "server", "start testacular server", ->

    #Mark the task as async but never call done, so the server stays up
    done = @async()
    testacular.server.start configFile: "test/test-config.js"

  grunt.registerTask "test", "run tests (make sure server task is run first)", ->
    done = @async()
    grunt.utils.spawn
      cmd: (if process.platform is "win32" then "testacular.cmd" else "testacular")
      args: (if process.env.TRAVIS then ["start", "test/test-config.js", "--single-run", "--no-auto-watch", "--reporter=dots", "--browsers=Firefox"] else ["run"])
    , (error, result, code) ->
      if error
        grunt.warn "Make sure the testacular server is online: run `grunt server`.\n" + "Also make sure you have a browser open to http://localhost:8080/.\n" + error.stdout + error.stderr

        #the testacular runner somehow modifies the files if it errors(??).
        #this causes grunt's watch task to re-fire itself constantly,
        #unless we wait for a sec
        setTimeout done, 1000
      else
        grunt.log.write result.stdout
        done()

