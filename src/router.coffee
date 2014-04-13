App.Router.map ->
  @resource 'tasks', { path: '/' }, ->
    @route 'active'
    @route 'complete'

App.TasksRoute = Ember.Route.extend
  model: ->
    @store.find('task')

App.TasksIndexRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('tasks').setTasks @store.find('task')

App.TasksActiveRoute = Ember.Route.extend
  setupController: ->
    tasks = @store.filter 'task', (task) ->
      !task.get('complete')
    @controllerFor('tasks').setActiveTasks tasks

App.TasksCompleteRoute = Ember.Route.extend
  setupController: ->
    tasks = @store.filter 'task', (task) ->
      task.get('complete')
    @controllerFor('tasks').setCompletedTasks tasks
