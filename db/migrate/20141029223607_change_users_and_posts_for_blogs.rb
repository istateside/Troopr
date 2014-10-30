class ChangeUsersAndPostsForBlogs < ActiveRecord::Migration
  def change
    rename_column :posts, :user_id, :blog_id
    rename_column :posts, :previous_user_id, :previous_blog_id
    rename_column :reblogs, :user_id, :blog_id
    rename_column :reblogs, :previous_user_id, :previous_blog_id
    rename_column :likes, :user_id, :blog_id    
  end
end
