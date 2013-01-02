aMarked.directive 'markdownProcessor', ->
  restrict: 'A'
  link: (scope, elem, attrs) ->
    markedOpts =
      gfm: true,
      sanitize: true
      highlight: (code, lang) ->
        if lang and hljs.LANGUAGES[lang]
          hl = hljs.highlight(lang, code).value
        else if lang and lang is "auto"
          hl = hljs.highlightAuto(code).value
        else
          hl = code

        hl

    scope.$watch 'markdown', (md) ->
      scope.$emit 'markdownChange', md
      output = marked(md, markedOpts)
      scope.preview = output
      return