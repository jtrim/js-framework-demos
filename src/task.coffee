App.Task = Ember.Object.extend {
  complete: false
  save: ->
    LocalStorage.set('tasks', @getProperties('id', 'complete', 'description'))
}

App.Task.reopenClass

  all: ->
    Ember.A(LocalStorage.all('tasks')).map (taskAttrs) ->
      App.Task.create(taskAttrs)

  where: (conditions) ->
    _.filter @all(), (task) ->
      _.isEqual _.pick(task, _.keys(conditions)...), conditions

  current: -> @where(complete: false)
  done:    -> @where(complete: true)


  ## MODIFYING
  ##
  #update: (task) ->
   #LocalStorage.set('tasks', task)
  #destroy: (task) ->
   #LocalStorage.remove('tasks', task)
  #clear: ->
   #LocalStorage.clear('tasks')
  #create: (taskAttributes) ->
    #taskAttributes.complete ||= false
    #LocalStorage.set('tasks', taskAttributes)
