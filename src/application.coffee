App.config ($routeProvider) ->
  $routeProvider
    .when "/", templateUrl: 'tasks-template', controller: 'TasksController', reloadOnSearch: false

App.controller 'TasksController', ($scope, $routeParams, Task) ->

  setTasks = ->
    $scope.tasks = if match = String($routeParams.state).match /(current|done)/
      Task[match[0]]()
    else
      Task.all()

  setTasks()

  $scope.$on '$routeUpdate', -> setTasks()

  $scope.$watch 'tasks', (changes) ->
    _.each changes, (task) ->
      Task.update _.pick(task, 'id', 'description', 'complete')
    $scope.taskCount = Task.all().length
    $scope.incompleteCount = Task.where(complete: false).length
  , true
  $scope.classFor = (task) ->
    if task.complete
      'complete'
  $scope.taskSorter = (task) ->
    "#{task.complete}#{task.description}"
  $scope.nukeAllTasks = ->
    Task.clear()
    $scope.tasks = Task.all()

App.controller 'NewTaskController', ($scope, Task) ->
  $scope.clearCompletedTasks = ->
    _.each Task.where(complete: true), (task) ->
      Task.destroy(task)
    $scope.$parent.$parent.tasks = Task.all()
  $scope.clearAllTasks = ->
    $scope.$parent.$parent.tasks = Task.clear()

  $scope.addTask = (taskForm, task) ->
    if taskForm.$valid
      Task.create task
      $scope.task = {}
      $scope.$parent.$parent.tasks = Task.all()
