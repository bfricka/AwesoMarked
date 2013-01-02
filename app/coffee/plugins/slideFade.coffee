# By default requires jQuery.easing by default
# change default easing to 'swing' if not using

# jQuery.slideFade
# Copyright © Brian Frichette, 2012+, All Rights Reserved.
# License: MIT http://opensource.org/licenses/mit-license.php

# Usage:

# @param {String} type A string value of either 'show', 'hide', or 'toggle' (default: 'toggle')
# @param {Boolean} horiz Whether the action is horizontal (default: false)
# @param {Object} options A map of options. See jQuery.animate for documentation (defaults shown below)
# @return {Object} jQuery object for chaining

# Examples:

# $(el).slideFade({easing: 'easeOutBounce'}) // Toggles element with a bounce animation



do ->
  $ = jQuery
  $.fn.extend 'slideFade': (type, horiz, options) ->
    # Start out with some param normalization

    # args = [type, horiz, options]

    # for arg in args
    #   argType = $.type(arg)
    #   switch argType
    #     when 'string'


    checkType = $.type(type)
    switch checkType
      when 'number'
        options = { duration: type }
        type = 'toggle'
      when 'object'
        options = type
        type = 'toggle'
      else
        type = if type? and checkType is 'string' then type else 'toggle'

    checkHoriz = $.type(horiz)
    switch checkHoriz
      when 'number'
        options = { duration: horiz }
        horiz = false
      when 'object'
        options = horiz
        horiz = false
      else
        horiz = if horiz? and checkHoriz is 'boolean' then horiz else false

    defaults =
      duration : 600
      easing   : 'easeOutExpo'
      queue    : false
      complete : ->

    o = $.extend defaults, options

    # Adaption of jQuery genFx function only we are allowing
    # either height or width, not both
    animProps = do ->
      props = ['Top', 'Right', 'Bottom', 'Left']
      attrs = if horiz then { 'width': type } else { 'height': type }
      i     = if horiz then 1 else 0

      while i < 4
        which = props[i]
        attrs["margin" + which] = attrs["padding" + which] = type
        i += 2

      attrs

    getOpacityProps = (el) ->
      op = {}
      switch type
        when 'show'
          op.opacity  = 1
          op.duration = o.duration * 1.8
        when 'hide'
          op.opacity  = 0
          op.duration = o.duration * 0.88
        when 'toggle'
          if el.is(':visible')
            op.opacity  = 0
            op.duration = o.duration * 0.88
          else
            op.opacity  = 1
            op.duration = o.duration * 1.8
      op


    doAnim = (el) ->
      # Set opacity target value
      op = getOpacityProps(el)

      el
      .stop(true, true)
      .animate(animProps, o)
      .animate({'opacity' : op.opacity}, op.duration, o.easing)

    @each ->
      $this = $(@)
      if horiz
        animProps.height = $this.height()
      doAnim($this)

    @

  # Slide Fade Up Alias
  $.fn.extend 'slideFadeUp': (opts) ->
    $.fn.slideFade.call(this, 'hide', opts)
    return

  $.fn.extend 'slideFadeDown': (opts) ->
    $.fn.slideFade.call(this, 'show', opts)
    return

  $.fn.extend 'slideFadeIn': (opts) ->
    $.fn.slideFade.call(this, 'show', true, opts)
    return

  $.fn.extend 'slideFadeOut': (opts) ->
    $.fn.slideFade.call(this, 'hide', true, opts)
    return

  return