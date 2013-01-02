Ace.factory "VimHandler", ->
  ace.require("ace/keyboard/vim").handler

Ace.factory "EmacsHandler", ->
  ace.require("ace/keyboard/emacs").handler

Ace.factory "ace", ->
  ace.edit "editor"

Ace.factory "AceRange", ->
  ace.require("ace/range").Range

Ace.factory "EditSession", ->
  ace.require("ace/edit_session").EditSession
