# Ace.directive 'aceEdit', [
#   '$timeout'
#   ($timeout) ->
#     (scope, elem, attrs) ->
#       $timeout ->
#         scope.editor = ace.edit(elem)
#         scope.editor.setTheme('ace/theme/twilight')
#         scope.editor.setMode('ace/mode/markdown')
#       , 1
# ]