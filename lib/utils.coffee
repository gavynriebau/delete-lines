fs = require 'fs'

module.exports =
  loadHtmlIntoElement: (el, path, callback) ->
    packagePath = atom.packages.resolvePackagePath('delete-lines')

    fs.readFile packagePath + path, (err, data) =>
      throw err if err?
      console.log "Loaded view at '#{path}':\n#{data.toString()}"
      el.innerHTML = data
      callback() if callback?
