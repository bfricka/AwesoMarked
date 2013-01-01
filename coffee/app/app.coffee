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