Template.notifications.helpers
  notifications: () ->
    Notifications.find(userId: Meteor.userId(), read: false)

  notificationCount: () ->
    Notifications.find(userId: Meteor.userId(), read:false).count()

Template.notifiation.helpers
  notificationPostPath: () ->
    Router.routes.postPage.path(_id: @postId)

Template.notification.events
  'click a': () ->
    Notifications.update(@_id, $set: read: true)