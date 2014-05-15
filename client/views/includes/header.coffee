Template.header.helpers
  activeRouteClass: () ->
    args = Array.prototype.slice.call arguments, 0

    active = _.any args, (name) ->
      Router.current() && Router.current().route.name == name

    active && 'active'