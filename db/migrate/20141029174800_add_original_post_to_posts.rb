class AddOriginalPostToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :original_post_id, :integer, default: nil
  end
end
