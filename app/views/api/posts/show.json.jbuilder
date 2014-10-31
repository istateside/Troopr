json.extract! @post, :id, :title, :body, :post_type, :url, :reblog, :previous_blog_id, :original_post_id, :created_at, :updated_at

json.byline post_byline(@post)

json.notes @post.get_notes do |note| 
	json.id note.id
	json.created_at note.created_at
	json.
end