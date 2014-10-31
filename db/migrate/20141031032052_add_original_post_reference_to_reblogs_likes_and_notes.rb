class AddOriginalPostReferenceToReblogsLikesAndNotes < ActiveRecord::Migration
  def change
    add_column :reblogs, :original_post_id, :integer, null:false
    add_column :likes, :original_post_id, :integer
    
    add_column :notes, :original_post_id, :integer, null:false
  end
end
