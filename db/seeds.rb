
User.create!([
  {email: "contraband90@gmail.com", password_digest: "$2a$10$IVzFl2/5GixQ1zGGX79Ljuk7T/80IiWEePNLyJNPtur8O8AjwKiGK", session_token: "alfaGegClU8bBsLOUXZfNQ", activated: true, activation_token: "CFOXgH1d65Jh3PfcSmbLMw", current_blog_id: 2},
  {email: "jimbo@whatever.com", password_digest: "$2a$10$0SqzIvzqrbmsejRPXoWF4etKFzOl41rt4Ft9FwZof5Cgc6zH6lwwa", session_token: "wvZq8uCW1DorY-LD5hcBNg", activated: true, activation_token: "b9WpuTCMjX1DSLi8eHlQBg", current_blog_id: nil}
])
Blog.create!([
  {blogname: "jimboooo", user_id: 1, description: "all jimbo, all the time", location: "jimbo city, jimbo nation", filepicker_url: nil},
  {blogname: "facebook-Test!", user_id: 2, description: "Just testin' the ooool facebooks", location: "", filepicker_url: nil},
  {blogname: "Testing a second blog", user_id: 2, description: "Aw yeah second blog", location: "", filepicker_url: nil}
])
Post.create!([
  {title: "Test post for styling", body: "wewefw", blog_id: 1, post_type: "text", url: nil, reblog: false, previous_blog_id: nil, original_post_id: nil},
  {title: "Testing two blogs", body: "Aw yiss.", blog_id: 2, post_type: "text", url: nil, reblog: false, previous_blog_id: nil, original_post_id: nil},
  {title: "Has anyone checked out reblogs?", body: "whuchu think", blog_id: 2, post_type: "text", url: nil, reblog: false, previous_blog_id: nil, original_post_id: nil},
  {title: "Has anyone checked out reblogs?", body: "whuchu think", blog_id: 2, post_type: "text", url: nil, reblog: true, previous_blog_id: 2, original_post_id: 3},
  {title: "", body: "I'm digging it.", blog_id: 1, post_type: "text", url: nil, reblog: false, previous_blog_id: nil, original_post_id: nil},
  {title: "Has anyone checked out reblogs?", body: "whuchu think", blog_id: 1, post_type: "text", url: nil, reblog: true, previous_blog_id: 2, original_post_id: 4}
])
Follow.create!([
  {source_id: 1, target_id: 2}
])
Like.create!([
  {blog_id: 2, post_id: 2},
  {blog_id: 1, post_id: 4}
])
Reblog.create!([
  {post_id: 3, blog_id: 2, previous_blog_id: 2},
  {post_id: 4, blog_id: 1, previous_blog_id: 2}
])