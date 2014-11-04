json.extract! @blog, :id, :blogname, :user_id, :description, :location, :created_at, :updated_at, :filepicker_url

json.is_followed current_blog.is_following?(@blog)

json.is_current current_blog == @blog
json.posts @blog.posts
