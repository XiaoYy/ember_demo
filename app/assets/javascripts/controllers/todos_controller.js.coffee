Todos.TodosController = Ember.ArrayController.extend
  actions: 
    createTodo: ()->
      title = @get('newTitle')
      unless title.trim() 
        return
      todo = @get('store').createRecord 'todo',
        title: title,
        isCompleted: false
      @set('newTitle', '')
      todo.save()
    clearCompleted: ()->
      completed = @filterBy('isCompleted', true)
      completed.invoke('deleteRecord')

      completed.invoke('save')

  hasCompleted: (()->
    @get('completed') > 0
    ).property('completed')

  completed: (()->
    @filterBy('isCompleted', true).get('length')
  ).property('@each.isCompleted')

  remaining: (()->
    @filterBy("isCompleted", false).get "length"
  ).property("@each.isCompleted")

  inflection: (()->
    remaining = @get("remaining")
    (if remaining is 1 then "item" else "items")
  ).property("remaining")

  allAreDone: ((key, value)->
    !!@get('length') && @everyProperty('isCompleted', true)
  ).property('@each.isCompleted')

  allAreDone: ((key, value)->
    if value is undefined
       !!@get('length') && @everyProperty('isCompleted', true)
    else
      @setEach('isCompleted', value)
      @invoke('save')
      value
  ).property('@each.isCompleted')