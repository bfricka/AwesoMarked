aMarked.directive 'stickyScroll', ->
  (scope, elem, attrs) ->
    exp = attrs.stickyScroll
    $mdTextarea = $(elem)
    mdTextarea = $mdTextarea[0]
    $preview = $('#preview')
    preview = $preview[0]

    getScrollTop = ->
      scrollPercent = mdTextarea.scrollTop / mdTextarea.scrollHeight
      preview.scrollHeight * scrollPercent

    scrollItems = (isEnabled) ->
      if isEnabled
        $mdTextarea.on 'scroll', (e) ->
          $('#preview').scrollTop getScrollTop()
      else
        $mdTextarea.off 'scroll'

    scrollItems(scope.$eval exp)

    scope.$watch ->
      scope.$eval exp
    , scrollItems