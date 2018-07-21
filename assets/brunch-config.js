exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      entryPoints: {
        "js/app.js": "js/app.js",
      }
    },
    stylesheets: {
      joinTo: "css/app.css"
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      ignore: [/vendor/] // Do not use ES6 compiler in vendor code
    },
    sass: {
      options: {
        includePaths: ["node_modules/font-awesome/scss"], // Tell sass-brunch where to look for files to @import
        precision: 8 // Minimum precision required by bootstrap-sass
      }
    },
    gzip: {
      paths: {
        javascript: "js",
        stylesheet: "css"
      },
      removeOriginalFiles: false,
      renameGzipFilesToOriginalFiles: false
    },
    copycat:{
      "fonts" : ["node_modules/font-awesome/fonts"],
      verbose : false, //shows each file that is copied to the destination directory
      onlyChanged: true //only copy a file if it's modified time has changed (only effective when using brunch watch)
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true
  }
};
