App.TaskLabelView = Ember.View.extend
  tagName: 'label'
  classNames: ['for-checkbox']

  attributeBindings: ['for']
  for: (->
    "task-#{@taskId}"
  ).property()

