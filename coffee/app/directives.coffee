aMarked.directive 'markdownProcessor', () ->
  restrict: 'A'
  link: (scope, elem, attrs) ->
    p = new MDProcessor(scope, elem, attrs)
    scope.$watch 'markdown', (md) ->
      scope.$emit 'markdownChange', md
      p.process(md)

aMarked.directive 'markdownPreview', () ->
  restrict: 'A'
  link: (scope, elem, attrs) ->
    scope.$watch 'preview', (els) ->
      prev = $(elem).empty().append(els)
      preCode = prev.find('pre')
      _.each preCode, (code) ->
        hljs.highlightBlock(code)