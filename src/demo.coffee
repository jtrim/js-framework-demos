App.IndexController = Ember.Controller.extend
  task: App.Task.create()
  tasks: App.Task.all()

  saveTask: ->
    @task.save()
    @set('task', App.Task.create())
