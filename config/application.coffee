# Exports an object that defines
#  all of the configuration needed by the projects'
#  depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

module.exports = (lineman) ->

  appendTasks:
    common: "copy:dev"
    dist: "copy:dist"

  prependTasks:
    dev: "markdown:dev"
    dist: "markdown:dist"

  removeTasks:
    common: lineman.config.application.removeTasks.common.concat("pug:templates", "jst", "jshint")

  markdown:
    options:
      author: "David A. Mosher"
      title: "david mosher"
      description: "personal and semi-professional opinions of a web designer and developer living in ottawa, canada"
      url: "http://blog.davemo.com"
      dateFormat: 'MMMM Do, YYYY'
