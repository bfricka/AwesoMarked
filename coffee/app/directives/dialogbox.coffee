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