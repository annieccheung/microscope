Template.postItem.helpers

  domain: () ->
    a = document.createElement 'a'
    a.href = this.url
    a.hostname

  ownPost: () ->
    @userId == Meteor.userId()

Template.postItem.events
  'click .upvote': (e) ->
    e.preventDefault()
    Meteor.call 'upvote', @_id