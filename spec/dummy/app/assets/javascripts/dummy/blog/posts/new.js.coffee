Dummy.Blog = {} if Dummy.Blog is undefined
Dummy.Blog.Posts = {} if Dummy.Blog.Posts is undefined

Dummy.Blog.Posts.New =->
  $('.javascript-content').html "Blog::Posts new content"

