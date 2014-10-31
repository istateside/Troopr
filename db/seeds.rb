Note.destroy_all
Like.destroy_all
Reblog.destroy_all
Post.destroy_all
Follow.destroy_all
Blog.destroy_all
User.destroy_all

maul = User.create!({email: "darthmaul@empire.com", password_digest: "$2a$10$qm8xwTqYACCqkhL9tDgCaOVLQmm0h3v9UkLv8v8rVgDUun0rcxL1m", session_token: "r9wySXxqq7-6kgPYPS7R3Q", activated: true, activation_token: "HjKUU7y-qa97BXEZKUe2EA", current_blog_id: nil})
jimbo = User.create!({email: "jimbo@whatever.com", password_digest: "$2a$10$5.Bm2jJh0eZZPvZzU36ibuV1yVM76R7FTxl.GzojlfGsd7LSBDcuq", session_token: "j5ajPTmpCTzGUyP5IzrNaQ", activated: true, activation_token: "nwFl39k1wG5A-jUf_oKm4A", current_blog_id: 1})
jblog1 = Blog.create!({blogname: "jimboooo", user_id: jimbo.id, description: "all jimbo, all the time", location: "jimbo city, jimbo nation", filepicker_url: nil})
mblog1 = Blog.create!({blogname: "darth-maul-goth", user_id: maul.id, description: "Master doesn't understand me.", location: "Korriban", filepicker_url: nil})
mblog2 = Blog.create!({blogname: "rebel-watch", user_id: jimbo.id, description: "KEEPING AN EYE OUT FOR THOSE DUMB REBELS!", location: "we are everywhere", filepicker_url: nil})
