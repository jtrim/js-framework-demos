
window.App ||= {}

class App.LocalStorage

  @nextIdFor: (name) ->
    @all(name).length + 1

  @all: (name) ->
    if !localStorage.getItem(name)
      localStorage.setItem name, JSON.stringify([])
    JSON.parse localStorage.getItem(name)

  @get: (name, id) ->
    _.findWhere @all(name), {id: id}

  @set: (name, obj) ->
    obj.id ||= @nextIdFor(name)
    obj.id = parseInt(obj.id)
    all = @all(name)
    ids = _.pluck(all, 'id')
    if (ids.indexOf(obj.id) > -1)
      all.splice(ids.indexOf(obj.id), 1)
    all.push obj
    localStorage.setItem name, JSON.stringify(all)
