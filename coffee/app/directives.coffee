aMarked.directive 'markdownProcessor', ->
  restrict: 'A'
  link: (scope, elem, attrs) ->
    markedOpts =
      gfm: true,
      sanitize: true
      highlight: (code, lang) ->
        if lang and hljs.LANGUAGES[lang]
          hl = hljs.highlight(lang, code)
        else
          hl = hljs.highlightAuto(code)

        hl.value

    scope.$watch 'markdown', (md) ->
      scope.$emit 'markdownChange', md
      output = marked(md, markedOpts)
      scope.preview = output
      return

aMarked.directive 'markdownPreview', ->
  restrict: 'A'
  link: (scope, elem, attrs) ->
    scope.$watch 'preview', (els) ->
      $(elem).empty().append(els)
      # preCode = prev.find('pre')
      # _.each preCode, (code) ->
      #   hljs.highlightBlock(code)