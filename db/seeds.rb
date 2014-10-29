Follow.create!([
  {source_id: 16, target_id: 14}
])
Post.create!([
  {title: "Test post", body: "This here is a test brooooo", user_id: 1, post_type: "text", url: nil, reblog: false, original_user_id: nil},
  {title: "Second post", body: "Another post!", user_id: 1, post_type: "text", url: nil, reblog: false, original_user_id: nil},
  {title: "Third post!", body: "Wow! Holy cow! Damn!", user_id: 1, post_type: "text", url: nil, reblog: false, original_user_id: nil},
  {title: "THIS IS A TEST POST LOOK AT IT", body: "HAHAHAH TEST", user_id: 5, post_type: "text", url: nil, reblog: false, original_user_id: nil},
  {title: "", body: "Great stuff", user_id: 5, post_type: "text", url: nil, reblog: false, original_user_id: nil},
  {title: "latest post", body: "RIGHT NOW", user_id: 5, post_type: "text", url: nil, reblog: false, original_user_id: nil},
  {title: "I love cats", body: "They're super rad", user_id: 16, post_type: "text", url: nil, reblog: false, original_user_id: nil},
  {title: "Another post.", body: "Here's a post!", user_id: 16, post_type: "text", url: nil, reblog: false, original_user_id: nil},
  {title: "jimbo post!", body: "JIMBOOOO", user_id: 14, post_type: "text", url: nil, reblog: false, original_user_id: nil},
  {title: "JIMBO MAKE NEW POST", body: "Here's a post!", user_id: 14, post_type: "text", url: nil, reblog: false, original_user_id: nil},
  {title: "That Jimbo guy", body: "Is a real goon.", user_id: 16, post_type: "text", url: nil, reblog: false, original_user_id: nil}
])
User.create!([
  {email: "emailtest@email.com", username: "emailtest", password_digest: "$2a$10$BN1ZzAoF9vTToE70qNpP/.FG31q6TRiEHVJRwTwPL0LrspB4ZWPxq", session_token: "WC6_Y5MhCAQ7ybx8hCfoMQ", activated: false, activation_token: "f"},
  {email: "jimbo@whatever.com", username: "jimbo", password_digest: "$2a$10$FmwInjU4QK.GIS4Ah..Mb.IHOq1Xd9Ufhb/aClQnhLVQKqipe1To.", session_token: "0LQR6uBKv8TE9nf5DhOctg", activated: false, activation_token: "f"},
  {email: "catguy@cats.com", username: "catguy", password_digest: "$2a$10$8O50ObRC9qVgCN.5GCblferiXlVHavl0YF8sZuamws1fxcQseqlpC", session_token: "BqXdcIq_j2MkkG-BTTq1Lw", activated: true, activation_token: "8cIZkn-uhwvHmtd0dNIpeA"}
  
  # passwords: testtest, whatever, catscats
])
