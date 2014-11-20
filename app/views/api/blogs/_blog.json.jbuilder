json.extract! blog, :id, :blogname, :user_id, :description, :location, :created_at, :updated_at, :filepicker_url

json.followers blog.followers
json.following blog.following

json.is_followed current_blog.is_following?(blog)

json.is_current current_blog == blog
json.posts do
  post_page = blog.posts.page(params[:page])
  json.page_number params[:page]
  json.total_pages post_page.total_pages
  json.posts post_page, partial: 'api/posts/post', as: :post
end
