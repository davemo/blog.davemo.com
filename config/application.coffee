# Exports an object that defines
#  all of the configuration needed by the projects'
#  depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

module.exports = require(process.env['LINEMAN_MAIN']).config.extend "application",

  loadNpmTasks: [
    "grunt-markdown-blog",
    "grunt-contrib-copy",
    "grunt-contrib-less"
  ]

  markdown:
    options:
      author: "David Mosher"
      title: "david mosher"
      description: "personal and semi-professional opinions of a web designer and developer living in ottawa, canada"
      url: "http://blog.davemo.com"
      rssCount: 10
      dateFormat: 'MMMM Do, YYYY'
      disqus: "davidmosher"
      layouts:
        wrapper: "app/templates/wrapper.us"
        index: "app/templates/index.us"
        post: "app/templates/post.us"
        archive: "app/templates/archive.us"
      paths:
        posts: "app/posts/*.md"
        index: "index.html"
        archive: "archive.html"
        rss: "index.xml"

    dev:
      dest: "generated"
      context:
        js: "/js/app.js"
        css: "/css/app.css"

    dist:
      dest: "dist"
      context:
        js: "/js/app.js"
        css: "/css/app.css"

  removeTasks:
    common: "jshint"
