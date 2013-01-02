#@codekit-prepend "../jQuery.easing.coffee"
#import "../jQuery.easing.coffee"

#@codekit-prepend "../slideFade.coffee"
#import "../slideFade.coffee"

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

#@codekit-append "directives/directives.coffee"
#import "directives/directives.coffee"

#@codekit-append "filters/filters.coffee"
#import "filters/filters.coffee"

#@codekit-append "services/services.coffee"
#import "services/services.coffee"

#@codekit-append "controllers/controllers.coffee"
#import "controllers/controllers.coffee"