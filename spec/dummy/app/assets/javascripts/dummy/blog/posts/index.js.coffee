Dummy.Blog = {} if Dummy.Blog is undefined
Dummy.Blog.Posts = {} if Dummy.Blog.Posts is undefined

Dummy.Blog.Posts.Index =->
  $('.javascript-content').html "Blog::Posts index content"

