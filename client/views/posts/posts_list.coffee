Template.postsList.helpers
  postsWithRank: () ->
    @posts.rewind()
    return @posts.map (post, index, cursor) ->
      post._rank = index
      console.log post._rank
      return post
