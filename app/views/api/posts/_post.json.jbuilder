json.extract! post, :id, :title, :body, :post_type, :url, :reblog, :blog_id, :previous_blog_id, :original_post_id, :created_at, :updated_at

json.is_liked current_blog.has_liked?(post)

json.blogname post.blog.blogname

json.avatar_url filepicker_image_url(post.blog.filepicker_url, w:64, h:64, fit: 'clip')
json.big_url filepicker_image_url(post.blog.filepicker_url, w:100, h:100, fit: 'clip')

if post.reblog
  json.previous_blogname post.previous_blog.blogname
end

json.notes post.get_notes do |note|
   json.id note.id
   json.created_at note.created_at
   json.updated_at note.updated_at
   json.notable_id note.notable_id
   json.notable_type note.notable_type
   json.render note.render
   if note.notable_type === ('Reblog')
     json.first_blog_id note.notable.reblogger.id
     json.second_blog_id note.notable.previous_blog.id
   elsif note.notable_type === ('Like')
     json.first_blog_id note.notable.blog.id
   else
     json.first_blog_id note.notable.blog.id
   end
end
