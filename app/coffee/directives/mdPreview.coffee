aMarked.directive 'markdownPreview', ->
  restrict: 'A'
  link: (scope, elem, attrs) ->
    scope.$watch 'preview', (els) ->
      $(elem).empty().append(els)