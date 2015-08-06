DeleteLinesView = require './delete-lines-view'
{CompositeDisposable} = require 'atom'

module.exports = DeleteLines =
  deleteLinesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @deleteLinesView = new DeleteLinesView(state.deleteLinesViewState)
    @bottomPanel = atom.workspace.addBottomPanel(item: @deleteLinesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'delete-lines:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'core:cancel': => @bottomPanel.hide()

  deactivate: ->
    @bottomPanel.destroy()
    @subscriptions.dispose()
    @deleteLinesView.destroy()

  serialize: ->
    deleteLinesViewState: @deleteLinesView.serialize()

  toggle: ->
    if @bottomPanel.isVisible()
      @bottomPanel.hide()
    else
      @bottomPanel.show()
