requireDir  = require('require-dir')
gulp        = require('gulp')
runSequence = require('run-sequence').use(gulp)
plugins     = require('gulp-load-plugins')({
  camelize: true,
  lazy: true
})

isBuild = process.argv[3] == "build"
config = 
  isWatching: !isBuild
  isDevelopment: !isBuild
  isProduction: isBuild
  logger: require('./util/logger')
  locals: require("../src/locals")
  dir:
    src:
      base: './src'
      styles: './src/styles/'
      images: './src/images/'
      htdocs: './src/htdocs/'
      scripts: './src/scripts/'
    build: 
      base: './build'
      script: 'app.js'
  

for name, task of requireDir('tasks')
  console.log(name)
  task(gulp,plugins,config)


gulp.task('default', ['watch'])