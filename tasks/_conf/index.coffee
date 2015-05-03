# conf
S =
  PATH: '/'
  SRC: 'src'
  DEST: 'public'

module.exports =
  S: S

  serve:
    notify: false
    startPath: S.PATH
    host: '127.0.0.1'
    open: 'external'
    server:
      baseDir: './'
      index: "#{S.DEST}#{S.PATH}/"
      routes:
        "#{S.PATH}": "#{S.DEST}#{S.PATH}/"

  scripts:
    browserifyOpts:
      entries: ["./#{S.SRC}/js/main.cjsx"]
      extensions: ['.coffee', '.cjsx']
      transform: ['coffee-reactify', 'react-jade']
    dest: "#{S.DEST}#{S.PATH}/js"

  uglify:
    src: "#{S.DEST}#{S.PATH}/js/main.js"
    dest: "#{S.DEST}#{S.PATH}/js"

  jade:
    src: [
      "#{S.SRC}/index.jade"
    ]
    dest: "#{S.DEST}#{S.PATH}"

  stylus:
    src: [
      "#{S.SRC}/css/main.styl"
    ]
    dest: "#{S.DEST}#{S.PATH}/css"

  minifyCss:
    src: [
      "#{S.DEST}#{S.PATH}/css/octicons.css"
      "#{S.DEST}#{S.PATH}/css/main.css"
    ]
    dest: "#{S.DEST}#{S.PATH}/css"

  clean: ["#{S.DEST}#{S.PATH}"]

  replace:
    src: "#{S.DEST}#{S.PATH}/index.html"
    dest: "#{S.DEST}#{S.PATH}"
    replacements: [
      ['main.js?v', "main.min.js?v#{Date.now()}"]
      ['main.css?v', "main.min.css?v#{Date.now()}"]
    ]

  copy:
    src: [
      './node_modules/octicons/octicons/octicons.{css,eot,svg,ttf,woff}'
    ]
    dest: "#{S.DEST}/css"
