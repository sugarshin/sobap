// config

const D = {
  PATH: '/',
  SRC: 'src',
  DEST: 'public'
};

export default {
  D: D,

  design: {
    notify: false,
    startPath: D.PATH,
    host: '127.0.0.1',
    open: 'external',
    server: {
      baseDir: './design'
    }
  },

  serve: {
    notify: false,
    startPath: D.PATH,
    host: '127.0.0.1',
    open: 'external',
    server: {
      baseDir: './',
      index: `${D.DEST}${D.PATH}/`,
      routes: (() => {
        let obj = {};
        obj[D.PATH] = `${D.DEST}${D.PATH}/`;
        return obj;
      })()
    }
  },

  scripts: {
    browserifyOpts: {
      entries: [`./${D.SRC}/js/main.jsx`],
      extensions: ['.jsx', '.cjsx', '.coffee'],
      transform: ['babelify', 'coffee-reactify', 'react-jade']
    },
    dest: `${D.DEST}${D.PATH}/js`
  },

  uglify: {
    src: `${D.DEST}${D.PATH}/js/main.js`,
    dest: `${D.DEST}${D.PATH}/js`
  },

  jade: {
    src: [
      `${D.SRC}/html/index.jade`
    ],
    dest: `${D.DEST}${D.PATH}`
  },

  stylus: {
    src: [
      `${D.SRC}/css/main.styl`
    ],
    dest: `${D.DEST}${D.PATH}/css`
  },

  minifyCss: {
    src: [
      `${D.DEST}${D.PATH}/css/main.css`,
      `${D.DEST}${D.PATH}/css/octicons.css`
    ],
    dest: `${D.DEST}${D.PATH}/css`
  },

  clean: {
    path: [`${D.DEST}${D.PATH}`]
  },

  replace: {
    src: `${D.DEST}${D.PATH}/index.html`,
    dest: `${D.DEST}${D.PATH}`,
    replacements: [
      ['<link rel="stylesheet" href="css/octicons.css">', ''],
      ['main.js?v', `main.min.js?v${Date.now()}`],
      ['main.css?v', `main.min.css?v${Date.now()}`]
    ]
  }
}
