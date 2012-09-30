#@codekit-prepend "../plugins.coffee"
#import "../plugins.coffee"

class MDProcessor
  constructor: (@scope, @elem, @attrs)->

  regexp:
    h1: /^(?:#{1}\s?)([^#]+)/gi

  process: (md) ->
    _.each @regexp, (exp) ->
      match = exp.test md
      if match
        console.log md.match exp
    @scope.preview = md


aMarked = angular.module 'aMarked', [] # Create our app

#@codekit-append "directives.coffee"
#import "directives.coffee"

#@codekit-append "filters.coffee"
#import "filters.coffee"

#@codekit-append "services.coffee"
#import "services.coffee"

#@codekit-append "controllers.coffee"
#import "controllers.coffee"