requireDir  = require('require-dir')
gulp        = require('gulp')
runSequence = require('run-sequence').use(gulp)
plugins     = require('gulp-load-plugins')({
  camelize: true,
  lazy: true
})
isDevelopment = process.argv[2] == undefined
config = 
  isWatching: isDevelopment
  isDevelopment: isDevelopment
  isProduction: !isDevelopment
  logger: require('./util/logger')
  locals: {siteURL:'http://hacktbilisi.com'}
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
  task(gulp,plugins,config)


gulp.task('default', ['watch'])