aMarked.controller 'MainAppCtrl', ['$scope', ($scope) ->
  $scope.stor = stor = new Stor()
  $scope.title = "ng-Bootstrap"
  $scope.filename = "Untitled"
  $scope.preview = ''

  getSavedState = do ->
    md = stor.get('aMarked')
    filename = stor.get('')
    $scope.markdown = if md? then md else ''

  $scope.$on 'markdownChange', (e, md) ->
    stor.set('aMarked', md)
]