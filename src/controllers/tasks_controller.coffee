App.TasksController = Ember.ArrayController.extend
  itemController: 'task'
  sortProperties: ['complete', 'title']
  statusLine: (->
    taskLabel = (count) ->
      if count == 1 then "task" else "tasks"
    length = @get('length')
    if @get('filterState')
      "#{length} #{@get('filterState')} #{taskLabel(length)}"
    else
      "#{length} #{taskLabel(length)}, #{@countIncompleteTasks()} left to do."
  ).property('length', '@each.complete')

  setTasks: (tasks, state) ->
    @setProperties
      model: tasks
      filterState: state

  setCompletedTasks: (tasks) ->
    @setTasks tasks, 'completed'

  setActiveTasks: (tasks) ->
    @setTasks tasks, 'active'

  countIncompleteTasks: ->
    @reduce (acc, val) ->
      if !val.get('complete') then acc + 1 else acc
    , 0

  actions:
    nuke: ->
      if confirm("Nuking. Are you sure?")
        @forEach (taskController) ->
          task = taskController.get('model')
          task.deleteRecord()
          task.save()

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

