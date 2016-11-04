# Exports an object that defines
#  all of the configuration needed by the projects'
#  depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

module.exports = (lineman) ->

  copy:
    dev:
      files: [ expand: true, cwd: 'static', src: '**', dest: 'generated' ]
    dist:
      files: [ expand: true, cwd: 'static', src: '**', dest: 'dist' ]

  appendTasks:
    common: lineman.config.application.appendTasks.common.concat("copy:dev")
    dist: lineman.config.application.appendTasks.common.concat("copy:dist")

  removeTasks:
    common: lineman.config.application.removeTasks.common.concat(
      "pug:templates", "jst", "jshint")

  markdown:
    options:
      author: "David Mosher"
      title: "david mosher"
      description: "personal and semi-professional opinions of a web designer and developer living in ottawa, canada"
      url: "http://blog.davemo.com"
      dateFormat: 'MMMM Do, YYYY'
      disqus: "davidmosher"
