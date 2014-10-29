class AddReblogsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :reblog, :boolean, default: false
    add_column :posts, :original_user_id, :integer
  end
end
