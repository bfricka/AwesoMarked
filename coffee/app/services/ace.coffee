aMarked.factory "VimHandler", ->
  ace.require("ace/keyboard/vim").handler

aMarked.factory "EmacsHandler", ->
  ace.require("ace/keyboard/emacs").handler

aMarked.factory "ace", ->
  ace.edit "editor"

aMarked.factory "AceRange", ->
  ace.require("ace/range").Range

aMarked.factory "EditSession", ->
  ace.require("ace/edit_session").EditSession
