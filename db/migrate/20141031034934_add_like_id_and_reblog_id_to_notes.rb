class AddLikeIdAndReblogIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :like_id, :integer
    add_index :notes, :like_id
  end
end
