aMarked.controller 'MainAppCtrl', ['$scope', ($scope) ->
  $scope.stor = stor = new Stor()
  $scope.title = "ng-Bootstrap"
  $scope.preview = ''

  getSavedState = do ->
    md = stor.get('aMarkedMarkdown')
    filename = stor.get('aMarkedFile')
    $scope.markdown = if md? then md else ''
    $scope.filename = if filename? then filename else 'Untitled'

  $scope.editFileName = false

  $scope.$on 'markdownChange', (e, md) ->
    stor.set('aMarkedMarkdown', md)

  $scope.updateFilename = (e) ->
    e.preventDefault()
    stor.set('aMarkedFile', $scope.filename)
    $scope.editFileName = false
]