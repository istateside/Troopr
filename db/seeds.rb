Note.destroy_all
Like.destroy_all
Reblog.destroy_all
Post.destroy_all
Follow.destroy_all
Blog.destroy_all
User.destroy_all

User.create!([
  {email: "darthmaul@empire.com", password_digest: "$2a$10$qm8xwTqYACCqkhL9tDgCaOVLQmm0h3v9UkLv8v8rVgDUun0rcxL1m", session_token: "r9wySXxqq7-6kgPYPS7R3Q", activated: true, activation_token: "HjKUU7y-qa97BXEZKUe2EA", current_blog_id: nil},
  {email: "jimbo@whatever.com", password_digest: "$2a$10$5.Bm2jJh0eZZPvZzU36ibuV1yVM76R7FTxl.GzojlfGsd7LSBDcuq", session_token: "j5ajPTmpCTzGUyP5IzrNaQ", activated: true, activation_token: "nwFl39k1wG5A-jUf_oKm4A", current_blog_id: 1}
])
Blog.create!([
  {blogname: "jimboooo", user_id: 1, description: "all jimbo, all the time", location: "jimbo city, jimbo nation", filepicker_url: nil},
  {blogname: "darth-maul-goth", user_id: 2, description: "Master doesn't understand me.", location: "Korriban", filepicker_url: nil},
  {blogname: "rebel-watch", user_id: 1, description: "KEEPING AN EYE OUT FOR THOSE DUMB REBELS!", location: "we are everywhere", filepicker_url: nil}
])
Follow.create!([
  {source_id: 2, target_id: 3},
  {source_id: 3, target_id: 1},
  {source_id: 1, target_id: 2},
  {source_id: 1, target_id: 3}
])
Post.create!([
  {title: "", body: "Darth Jimbo, coming at ya", blog_id: 1, post_type: "text", url: nil, reblog: false, previous_blog_id: nil, original_post_id: 3599},
  {title: "bad day at work.", body: "couldn't find those droids =\\", blog_id: 1, post_type: "text", url: nil, reblog: false, previous_blog_id: nil, original_post_id: 3600},
  {title: "", body: "i just wanna do sith stuff with my friends", blog_id: 2, post_type: "text", url: nil, reblog: false, previous_blog_id: nil, original_post_id: 3601},
  {title: "", body: "anyone see that dopey looking dude that hangs out with chewbacca? what a goon", blog_id: 3, post_type: "text", url: nil, reblog: false, previous_blog_id: nil, original_post_id: 3602},
  {title: "", body: "anyone see that dopey looking dude that hangs out with chewbacca? what a goon", blog_id: 2, post_type: "text", url: nil, reblog: true, previous_blog_id: 3, original_post_id: 3602},
  {title: "", body: "i just wanna do sith stuff with my friends", blog_id: 1, post_type: "text", url: nil, reblog: true, previous_blog_id: 2, original_post_id: 3601},
  {title: "been practicing my hoverbike skills", body: "ever since jeff was taken out by that tree on Endor, I've been real concerned with hoverbike safety", blog_id: 1, post_type: "text", url: nil, reblog: false, previous_blog_id: nil, original_post_id: 3605}
])

Reblog.create!([
  {new_post_id: 3596, blog_id: 1, previous_blog_id: 1, previous_post_id: "3595", original_post_id: 3595},
  {new_post_id: 3597, blog_id: 1, previous_blog_id: 1, previous_post_id: "3596", original_post_id: 3595},
  {new_post_id: 3603, blog_id: 2, previous_blog_id: 3, previous_post_id: "3602", original_post_id: 3602},
  {new_post_id: 3604, blog_id: 1, previous_blog_id: 2, previous_post_id: "3601", original_post_id: 3601}
])

Like.create!([
  {blog_id: 2, post_id: 3602, original_post_id: 3602},
  {blog_id: 1, post_id: 3601, original_post_id: 3601}
])
Note.create!([
  {original_post_id: 3599, notable_id: 3599, notable_type: "Post"},
  {original_post_id: 3600, notable_id: 3600, notable_type: "Post"},
  {original_post_id: 3601, notable_id: 3601, notable_type: "Post"},
  {original_post_id: 3602, notable_id: 3602, notable_type: "Post"},
  {original_post_id: 3602, notable_id: 19, notable_type: "Like"},
  {original_post_id: 3602, notable_id: 3572, notable_type: "Reblog"},
  {original_post_id: 3601, notable_id: 20, notable_type: "Like"},
  {original_post_id: 3601, notable_id: 3573, notable_type: "Reblog"},
  {original_post_id: 3605, notable_id: 3605, notable_type: "Post"}
])