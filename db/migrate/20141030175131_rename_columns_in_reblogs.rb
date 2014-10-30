class RenameColumnsInReblogs < ActiveRecord::Migration
  def change
    rename_column :reblogs, :post_id, :new_post_id
  end
end
