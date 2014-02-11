Todos.EditTodoView = Ember.TextField.extend
  didInsertElement: ()->
    this.$().focus()
Ember.Handlebars.helper('edit-todo', Todos.EditTodoView)