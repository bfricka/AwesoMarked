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

aMarked.directive 'dialogbox', ->
  {
    transclude : true
    template   : "<div data-ng-transclude></div>"
    restrict   : "A"
    replace    : true
    link       : (scope, elem, attrs) ->
      $elem = $(elem).addClass('dialog')
      dur = 250
      opts =
        duration: dur
        queue: false
      # Watch width and adjust

      watchDimensions = (dims) ->
        # Set margin property type
        margin = if dims is 'width' then 'marginLeft' else 'marginTop'
        # Set measurement function
        measure = if dims is 'width' then 'outerWidth' else 'outerHeight'

        scope.$watch ->
          # Dirty check to see if element is hidden
          hidden = if $elem[0].style.display is 'none' then true else false
          last = @last # Cache for minification

          # If last is a function, return false. This will be true
          # exactly once, as after first construction, this turns
          # to the 'last value'
          return false if angular.isFunction(last)

          # Return last (break - don't run the change callback)
          # unless the element is visible
          return last if hidden

          # Get dimensions (equiv. $elem.outerHeight(), etc.)
          dim = $elem[measure].call($elem)

          # There is an odd bug where the dimensions can change by
          # a small (<2px) amount. I'm not sure what causes this,
          # however, we can do a quick check for this variance
          # and not fire the change evt if it's within limits
          dim = if Math.abs(dim - last) > 2 then dim else last
          dim
        , (dim) ->
          props = {}
          props[margin] = -(dim/2)
          $elem.animate props, opts
          return

      watchDimensions('width')
      watchDimensions('height')
      return
  }

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

aMarked.directive 'fadeShow', ->
  (scope, elem, attrs) ->
    $elem = $(elem)
    exp = attrs.fadeShow

    # Check if we're mobile and don't animate by default if so
    duration = 400

    # Fade fn. If init is true (initial load) and exp
    # is false then hide instantly (prevent flash of content)
    fadeElem = (toShow, init = false) ->
      if toShow
        $elem.fadeIn(duration)
      else
        if init then $elem.hide() else $elem.fadeOut(duration)
      return

    fadeElem(scope.$eval(exp), true)

    # Set watch
    scope.$watch ->
      scope.$eval exp
    , fadeElem

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
