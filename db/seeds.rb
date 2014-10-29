User.create!([
  {email: "emailtest@email.com", username: "emailtest", password_digest: "$2a$10$BN1ZzAoF9vTToE70qNpP/.FG31q6TRiEHVJRwTwPL0LrspB4ZWPxq", session_token: "WC6_Y5MhCAQ7ybx8hCfoMQ", activated: false, activation_token: "f"},
  {email: "jimbo@whatever.com", username: "jimbo", password_digest: "$2a$10$FmwInjU4QK.GIS4Ah..Mb.IHOq1Xd9Ufhb/aClQnhLVQKqipe1To.", session_token: "6dGz3MTSSQ2FX9nx6To8Ig", activated: true, activation_token: "i41jx84XgdGLyKOG4DlbbQ"},
  {email: "catguy@cats.com", username: "catguy", password_digest: "$2a$10$8O50ObRC9qVgCN.5GCblferiXlVHavl0YF8sZuamws1fxcQseqlpC", session_token: "SfswoRfJgrMHpr-EaJB23w", activated: true, activation_token: "8cIZkn-uhwvHmtd0dNIpeA"}
])
Follow.create!([
  {source_id: 3, target_id: 2}
])
Post.create!([
  {title: "Cats", body: "whoooooo", user_id: 3, post_type: "text", url: nil, reblog: false, previous_user_id: nil, original_post_id: nil},
  {title: "Here's another cat!", body: "Test cat!", user_id: 3, post_type: "text", url: nil, reblog: false, previous_user_id: nil, original_post_id: nil},
  {title: "", body: "Jimbo rulez", user_id: 2, post_type: "text", url: nil, reblog: false, previous_user_id: nil, original_post_id: nil},
  {title: "JIMBO", body: "RULES", user_id: 2, post_type: "text", url: nil, reblog: false, previous_user_id: nil, original_post_id: nil},
  {title: "", body: "Jimbo rulez", user_id: 3, post_type: "text", url: nil, reblog: true, previous_user_id: 2, original_post_id: 3}
])
Reblog.create!([
  {post_id: 3, user_id: 3, previous_user_id: 2}
])
  
