json.extract! user, :id, :email, :created_at, :updated_at, :activated, :current_blog_id

json.blogs user.blogs, partial: 'api/blogs/blog', as: :blog
