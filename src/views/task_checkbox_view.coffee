App.TaskCheckboxView = Ember.Checkbox.extend
  init: ->
    this.elementId = "task-#{@taskId}"
    this._super()
