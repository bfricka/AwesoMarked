aMarked.directive 'markdownProcessor', () ->
  restrict: 'A'
  link: (scope, elem, attrs) ->
    p = new MDProcessor(scope, elem, attrs)
    scope.$watch 'markdown', (md) ->
      p.process(md)