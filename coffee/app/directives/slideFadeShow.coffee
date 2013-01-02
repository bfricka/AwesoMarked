aMarked.directive 'slideFadeShow', ->
  (scope, elem, attrs) ->
    $elem = $(elem)
    exp = attrs.slideFadeShow
    duration = 600

    slideElem = (toShow, init = false) ->
      # If init is true (initial load) and exp is false
      # then hide instantly (prevent flash of content)
      if not toShow and init is true then return $elem.hide()
      # Otherwise set type and delegate to animation fn.
      if toShow
        $elem.slideFadeDown(duration)
      else
        $elem.slideFadeUp(duration)
      return

    # Initial load. Evaluate exp and set 'init' to true
    slideElem(scope.$eval(exp), true)

    # Set watch on slideFadeShow attr expression
    scope.$watch ->
      scope.$eval exp
    , slideElem