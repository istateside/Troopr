json.array! @posts do |post|
	json.extract! post, :id, :title, :body, :post_type, :url, :reblog, :previous_blog_id, :original_post_id, :created_at, :updated_at

	json.blogname post.blog.blogname
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
	end
end