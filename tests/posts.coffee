assert = require "assert"

suite "Post Method", ->
  test "cannot create post without login", (done, server, client) ->
    client.eval ->
      Meteor.call "post",
        url: "http://a.com"
        title: "The Title"
      , (err) ->
        emit "posted", err


    client.on "posted", (err) ->
      assert.equal err.error, 401
      done()

  test "can create post with login", (done, server, client) ->
    client.eval ->
      Accounts.createUser
        username: "arunoda"
        password: "123456"
      , (err) ->
        emit "created", err

    client.on "created", (err) ->
      assert.equal err, null
      client.eval ->
        Meteor.call "post",
          title: "google"
          url: "http://google.com"
        , (err, id) ->
          emit "posted", err, id

    client.on "posted", (err, id) ->
      assert.equal err, null
      assert.ok id
      server.eval ->
        posts = Posts.find(title: "google").fetch()
        emit "posts", posts

    server.on "posts", (posts) ->
      assert.equal posts.length, 1
      done()