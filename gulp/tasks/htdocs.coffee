es = require('event-stream')
module.exports = (gulp, plugins, config)->
  i18n = require('../util/t')
  gulp.task 'htdocs', ->
    stream = gulp
      .src(config.dir.src.htdocs + "index.jade")
    files = []
    loop
      t = i18n.get()
      file = stream
        .pipe plugins.clone()
        .pipe plugins.jade
          pretty: config.idDevelopment
          locals:i18n.use(config.locals,t)
        .pipe plugins.rename
          dirname: t('languagePrefix')
      files.push file
      break if i18n.next()
    return es.merge.apply(es,files)
      .pipe(gulp.dest(config.dir.build.base))
      .pipe plugins.connect.reload()