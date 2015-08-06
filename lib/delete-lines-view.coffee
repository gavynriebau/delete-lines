utils = require './utils'
ko = require './knockout.debug.js'
window.ko = ko
ksb = require './knockout-secure-binding.js'

options =
  attribute: "data-bind"
  globals: window
  bindings: ko.bindingHandlers
  noVirtualElements: false

ko.bindingProvider.instance = new ko.secureBindingsProvider(options)

module.exports =
class DeleteLinesView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('delete-lines')

    # Create observable values
    @editorText = ko.observable()
    @useRegex = ko.observable true
    @ignoreCase = ko.observable true
    @invertMatch = ko.observable false

    # Load the HTML file.
    utils.loadHtmlIntoElement @element, '/html/delete-lines.html', () =>
      # Use knockoutjs data-binding.
      ko.applyBindings @, @element

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  toggleInvertMatch: =>
    @invertMatch(not @invertMatch())
    console.log "toggleInvertMatch: #{@invertMatch()}"

  toggleUseRegex: =>
    @useRegex(not @useRegex())
    console.log "toggleUseRegex: #{@useRegex()}"

  toggleIgnoreCase: =>
    @ignoreCase(not @ignoreCase())
    console.log "toggleIgnoreCase: #{@ignoreCase()}"

  onRemoveClick: =>
    text = @editorText()
    console.log "onRemoveClick: #{text}"

    if text?
      activeEditor = atom.workspace.getActiveTextEditor()
      contents = activeEditor.getText()

      updatedLines = []

      for line in contents.split(/\n/)
        if @useRegex()
          # Check if the line matched the regex
          regexOpts = if @ignoreCase() then "i" else ""
          re = new RegExp(".*#{text}.*", regexOpts)
          match = re.test line
        else
          # Check if the line contains the text
          src = if @ignoreCase() then line.toLowerCase() else line
          target = if @ignoreCase() then text.toLowerCase() else text
          match = src.indexOf(target) != -1

        if @invertMatch()
          match = not match

        #console.log "matched '#{line}': #{match}"
        if not match
          updatedLines.push line

      updatedContents = updatedLines.join "\n"
      activeEditor.setText updatedContents
