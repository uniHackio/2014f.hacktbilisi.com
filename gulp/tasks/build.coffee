runSequence = require('run-sequence')
module.exports = (gulp, plugins, config)->
  gulp.task 'build', (cb)->
    #TODO remove after gulp 4.0
    runSequence('clean',['scripts', 'htdocs', 'images', 'styles'],cb)