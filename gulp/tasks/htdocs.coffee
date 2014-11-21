es = require('event-stream')
localizer = require('../util/t')
merge = require('merge')
fs = require 'fs'
path = require 'path'

marked = require("marked")
renderer = new marked.Renderer()
GE2EN = ((set)->
  (string)->
    (Array::map.call string, (char)->
      set[char] || char).join('')
)({"ა":"a","ბ":"b","გ":"g","დ":"d","ე":"e","ვ":"v","ზ":"z","თ":"t","ი":"i","კ":"k'","ლ":"l","მ":"m","ნ":"n","ო":"o","პ":"p'","ჟ":"zh","რ":"r","ს":"s","ტ":"t'","უ":"u","ფ":"p","ქ":"k","ღ":"gh","ყ":"q","შ":"sh","ჩ":"ch","ც":"ts","ძ":"dz","წ":"ts'","ჭ":"ch'","ხ":"kh","ჯ":"j","ჰ":"h"})

renderer.heading = (text, level) ->
  escapedText = GE2EN(text).toLowerCase().replace(/[^\w]+/g, "-")
  "<h#{level} id=\"#{escapedText}\">#{text}</h#{level}>"
marked.setOptions renderer: renderer


module.exports = (gulp, plugins, config)->
  gulp.task 'htdocs', ->
    i18n = localizer(config.defaultLanguageKey,config.locals)
    stream = gulp
      .src(config.dir.src.htdocs + "index.jade")
    files = []
    loop
      files.push(((t)->
        stream
          .pipe plugins.clone()
          .pipe plugins.jade
            pretty: config.idDevelopment
            locals:merge true, config.data,
              t:t
              md:(filePath)->
                filePath = path.join(config.dir.src.htdocs,t('languagePrefix'),filePath)
                contents = fs.readFileSync(filePath,'utf8')
                marked(contents)
          .pipe plugins.rename
            dirname: t('languagePrefix')
      )(i18n.get()))
      break if i18n.next()
    return es.merge.apply(es,files)
      .pipe(gulp.dest(config.dir.build.base))
      .pipe plugins.connect.reload()