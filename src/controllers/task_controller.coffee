App.TaskController = Ember.ObjectController.extend
  actions:
    destroy: ->
      if confirm("Are you sure?")
        task = @get('model')
        task.deleteRecord()
        task.save()

  complete: ((key, value) ->
    model = @get('model')

    if value?
      model.set('complete', value)
      model.save()
      value
    else
      model.get('complete')
  ).property('model.complete')
