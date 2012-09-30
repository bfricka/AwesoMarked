#@codekit-prepend "../plugins.coffee"
#import "../plugins.coffee"

class MDProcessor
  constructor: (@scope, @elem, @attrs)->

  matchers: [
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
        tag: "ul"
        exp: /^(?:\*{1}\s?)([^*\r\n]+))/i
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
            str = self.buildString(tag, exp, line)
            output.push str

    console.log(output.join(''))
    @scope.preview = output.join('')
    console.log(lines)

  buildString: (tag, exp, line) ->
    content = line.match(exp)[1]
    switch tag
      when 'ul'
        str = "<#{tag}><li>#{content}</li></#{tag}>"
      else
        str = "<#{tag}>#{content}</#{tag}>"


aMarked = angular.module 'aMarked', [] # Create our app

#@codekit-append "directives.coffee"
#import "directives.coffee"

#@codekit-append "filters.coffee"
#import "filters.coffee"

#@codekit-append "services.coffee"
#import "services.coffee"

#@codekit-append "controllers.coffee"
#import "controllers.coffee"