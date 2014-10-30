class AddCurrentBlogIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_blog_id, :integer
  end
end
