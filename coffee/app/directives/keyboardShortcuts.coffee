aMarked.directive 'keyboardShortcuts', [
  '$document'
  ($document) ->
    (scope, elem, attr) ->
      mdTextarea = elem[0]

      joinLines = ->
        cursorPos = mdTextarea.selectionStart
        return unless cursorPos

        txtArr = mdTextarea.value.split('')
        txtArr[cursorPos] = ""

        finish = txtArr.length - cursorPos - 1
        i = cursorPos

        while i < finish
          currentChar = txtArr[i]
          if currentChar.match(/[ ]/i)
            currentChar = ""
          else
            break
          i++

        mdTextarea.value = txtArr.join('')
        mdTextarea.selectionStart = mdTextarea.selectionEnd = cursorPos
        return

      save = ->

      cmdCtrl =
        "74" : joinLines
        "83" : save

      ctrl = (e) ->
        keyCode = e.keyCode.toString()

        e.preventDefault() if keyCode in cmdCtrl

        if cmdCtrl[keyCode]
          cmdCtrl[keyCode].call(@)

      $document.on 'keydown', (e) ->
        if e.ctrlKey or e.metaKey
          ctrl(e)
]
