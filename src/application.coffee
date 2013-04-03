# Routes definition. Angular injects `$routeProvider`.
App.config ($routeProvider) ->
  $routeProvider
    # Note: we've set `reloadOnSearch` to false here so the controller doesn't
    # re-render the view contents. While in this case, re-rendering wouldn't
    # necessarily be bad, but imagine if we were making ajax calls to the
    # server on every render...
    .when "/", templateUrl: 'tasks-template', controller: 'TasksController', reloadOnSearch: false

# Angular controller for handling all non-form-related things.
# Angular injects `$scope`, `$routeParams`, and the `Task` model
App.controller 'TasksController', ($scope, $routeParams, Task) ->

  # Depending on if `$routeParams.state` is set, sets `$scope.tasks` to either
  # all tasks or some filtered subset
  setTasks = ->
    $scope.tasks = if match = String($routeParams.state).match /(current|done)/
      Task[match[0]]()
    else
      Task.all()

  # Initially set the tasks
  setTasks()

  # Any time the route changes (even the query string), `$scope` gets
  # a '$routeUpdate' event. Handle this by resetting `$scope.tasks`
  $scope.$on '$routeUpdate', -> setTasks()

  # Watch `$scope.tasks` for any changes so we know when to persist individual
  # task changes and update other properties on `$scope`
  $scope.$watch 'tasks', (changes) ->
    _.each changes, (task) ->
      Task.update _.pick(task, 'id', 'description', 'complete')

    # Template bindings for rendering the status bar below the list.
    $scope.taskCount = Task.all().length
    $scope.incompleteCount = Task.where(complete: false).length

  # See http://docs.angularjs.org/api/ng.$rootScope.Scope#$watch
  # This is the third parameter to `$scope.$watch`.
  # Watch for changes to object equality, not reference.
  , true

  # Template binding. Returns the classname for a given task row based on task
  # completeness.
  $scope.classFor = (task) ->
    if task.complete
      'complete'

  # Used in the `ng-repeat` that renders tasks. e.g. `ng-repeat='task in tasks | orderBy:taskSorter'`.
  # This sorts tasks by completed state, then by alphabetical order.
  $scope.taskSorter = (task) ->
    "#{task.complete}#{task.description}"

  # Remove all tasks and re-render the list.
  $scope.nukeAllTasks = ->
    Task.clear()
    $scope.tasks = Task.all()

# Angular controller for handling adding new tasks.
# Angular injects `$scope` and `Task`.
App.controller 'NewTaskController', ($scope, Task) ->

  # Template binding. Passes in `taskForm` and `task` from the template.
  $scope.addTask = (taskForm, task) ->
    if taskForm.$valid
      Task.create task
      $scope.task = {}

      # IMPORTANT: Angular implicitly creates a `FormController` inside any form.
      # By looking at the template, one would be lead to believe that the
      # parent of this controller is `TasksController`, but because of this
      # implicitly-created `FormController`, it's actually one level deeper.
      # This is also an ugly LoD violation.
      $scope.$parent.$parent.tasks = Task.all()
