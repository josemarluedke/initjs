Dummy.Blog = {} if Dummy.Blog is undefined
Dummy.Blog.Posts = {} if Dummy.Blog.Posts is undefined

Dummy.Blog.Posts.Show =->
  $('.javascript-content').html "Blog::Posts show content"

