class ChangePosts < ActiveRecord::Migration
  def change
    rename_column :posts, :original_user_id, :previous_user_id
  end
end
