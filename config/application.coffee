
# Exports an object that defines
#  all of the configuration needed by the projects'
#  depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

module.exports = (lineman) ->

  removeTasks:
    common: lineman.config.application.removeTasks.common.concat("coffee", "pug:templates", "handlebars", "jst", "jshint")

  markdown:
    options:
      author: "David Mosher"
      title: "David Mosher's Blog"
      description: "thoughts on software, music, design, and meaning"
      url: "https://blog.davemo.com"
      dateFormat: 'MMMM Do, YYYY'
