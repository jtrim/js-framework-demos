App.TaskController = Ember.ObjectController.extend
  editing: false
  actions:
    edit: ->
      @set('editing', true)

    cancel: ->
      @set('editing', false)

    update: ->
      @get('model').save()
      @set('editing', false)

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
