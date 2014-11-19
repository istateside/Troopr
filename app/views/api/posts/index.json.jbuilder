json.page_number params[:page].to_i
json.total_pages @posts.total_pages

json.posts @posts do |post|
	json.partial! 'post', post: post
end
