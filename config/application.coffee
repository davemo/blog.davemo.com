# Exports an object that defines
#  all of the configuration needed by the projects'
#  depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

module.exports = require(process.env['LINEMAN_MAIN']).config.extend "application",

  loadNpmTasks: ["grunt-markdown-blog"]

  markdown:
    options:
      author: "David Mosher"
      title: "david mosher"
      description: "personal and semi-professional opinions of a web designer and developer living in saskatoon, sk, canada"
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
        js: "/js/app.min.js"
        css: "/css/app.min.css"

  # Use grunt-markdown-blog in lieu of Lineman's built-in homepage task
  prependTasks:
    dev: "markdown:dev"
    dist: "markdown:dist"

  removeTasks:
    common: "homepage:dev"
    dist: "homepage:dist"

  watch:
    markdown:
      files: ["app/posts/*.md", "app/templates/*.us"]
      tasks: ["markdown:dev"]
