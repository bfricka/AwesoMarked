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
      $(elem).empty().append(els)