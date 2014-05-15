POST_HEIGHT = 80
Positions = new Meteor.Collection null

Template.postItem.helpers

  domain: () ->
    a = document.createElement 'a'
    a.href = this.url
    a.hostname

  ownPost: () ->
    @userId == Meteor.userId()

  upvotedClass: () ->
    userId = Meteor.userId()
    if userId && !_.include(@upvoters, userId)
      'btn-primary upvotable'
    else
      'disabled'

  attributes: () ->
    post = _.extend {}, Positions.findOne(postId: @_id), @
    newPosition = post._rank * POST_HEIGHT
    attributes = {}

    if not _.isUndefined post.position
      offset = post.position - newPosition
      attributes.style = "top: " + offset + "px"
      if offset is 0
        attributes.class = "post animate"

    Meteor.setTimeout () ->
      Positions.upsert postId: post._id,
        $set:
          position: newPosition

    attributes

Template.postItem.events
  'click .upvotable': (e) ->
    e.preventDefault()
    Meteor.call 'upvote', @_id