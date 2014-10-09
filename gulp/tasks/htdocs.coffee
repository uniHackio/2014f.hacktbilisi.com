module.exports = (gulp, plugins, config)->
  gulp.task 'htdocs', ->
    return gulp
      .src(config.dir.src.htdocs + "**/*.jade")
      .pipe(plugins.plumber())
#      .pipe(plugins.cache('jade'))
      .pipe(plugins.progeny())
      .pipe plugins.jade
        pretty: config.idDevelopment
        locals: config.locals
      .pipe(plugins.filter(["**index.html"]))
      .pipe(gulp.dest(config.dir.build.base))
      .pipe plugins.connect.reload()