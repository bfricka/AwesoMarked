#@codekit-prepend "../plugins.coffee"
#import "../plugins.coffee"

class MDProcessor
  constructor: (@scope, @elem, @attrs)->

  matchers: [
      {
        tag: "p"
        exp: /^([^#\*]+)/i
      }
      {
        tag: "h1"
        exp: /^(?:#{1}\s?)([^#]+)/i
      }
      {
        tag: "h2"
        exp: /^(?:#{2}\s?)([^#]+)/i
      }
      {
        tag: "h3"
        exp: /^(?:#{3}\s?)([^#]+)/i
      }
      {
        tag: "h4"
        exp: /^(?:#{4}\s?)([^#]+)/i
      }
      {
        tag: "h5"
        exp: /^(?:#{5}\s?)([^#]+)/i
      }
      {
        tag: "h6"
        exp: /^(?:#{6}\s?)([^#]+)/i
      }
      {
        tag: "li"
        exp: /^(?:\*{1}\s?)([^*\r\n]+)/i
      }
    ]

  process: (md) ->
    self = @
    lines = md.split /\n/gi
    output = []
    _.each lines, (line) ->
      if line?
        markupMatches = _.filter self.matchers, (matcher) ->
          matcher.exp.test(line) is true
        if markupMatches? and markupMatches.length
          _.each markupMatches, (matcher) ->
            tag = matcher.tag
            exp = matcher.exp
            el = self.buildElement(tag, exp, line)
            output.push el

    window.op = output
    self.needsParent(output)
    @scope.preview = output
    console.log(lines)

  buildElement: (tag, exp, line) ->
    d = document
    content = line.match(exp)[1]
    txt = d.createTextNode(content)
    el = d.createElement(tag)
    el.appendChild(txt)
    el

  needsParent: (output) ->
    $els = $(output)
    els = @jqToArray($els)
    len = els.length
    i = 0
    while i < len
      el = els[i]
      tag = el.tagName
      prev = if i is 0 then '' else els[i-1].tagName
      next = if i+1 is len then '' else els[i+1].tagName
      if tag is 'LI'
        unless prev is 'LI' then
      i++

  jqToArray: ($els) ->
    els = []
    for el in $els
      els.push el
    els
# Just my preferred syntax for working with storage
# as opposed to the amplify syntax
class Stor
  constructor: ->
    @amp = amplify.store
  get: (key) ->
    @amp(key)
  set: (key, val, exp = null) ->
    @amp(key, val, exp)
  del: (key) ->
    @amp(key, null)

aMarked = angular.module 'aMarked', [] # Create our app

#@codekit-append "directives.coffee"
#import "directives.coffee"

#@codekit-append "filters.coffee"
#import "filters.coffee"

#@codekit-append "services.coffee"
#import "services.coffee"

#@codekit-append "controllers.coffee"
#import "controllers.coffee"