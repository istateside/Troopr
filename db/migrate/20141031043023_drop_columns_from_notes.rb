class DropColumnsFromNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :like_id
    remove_column :notes, :post_id
    remove_column :notes, :text
  end
end
