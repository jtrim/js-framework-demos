App.TasksController = Ember.ArrayController.extend
  itemController: 'task'
  sortProperties: ['complete', 'title']
  actions:
    createTodo: ->
      @validate() && (=>
        title = @get('newTitle')

        task = @store.createRecord 'task',
          title: title
          complete: false

        @set('newTitle', '')

        task.save())()

  validate: ->
    title = @get('newTitle')
    if title?.trim().length
      @set('errors', '')
      return true
    else
      @set('errors', "can't save a blank task")
      return false

