App.Router.map ->
  @resource('tasks', { path: '/' })

App.TasksRoute = Ember.Route.extend
  model: ->
    @store.find('task')
