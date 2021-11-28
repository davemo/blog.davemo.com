module.exports = (lineman) ->

  removeTasks:
    common: lineman.config.application.removeTasks.common.concat("coffee", "pug:templates", "handlebars", "jst", "jshint")

  markdown:
    options:
      title: "David Mosher's Blog"
      description: "thoughts on software, music, design, and meaning"
      url: "https://blog.davemo.com"
      author: "David Mosher"
      authorUrl: "https://twitter.com/dmosher"
      dateFormat: "MMMM Do, YYYY"
      feedCount: 20
