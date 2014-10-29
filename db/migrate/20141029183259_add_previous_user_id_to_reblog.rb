class AddPreviousUserIdToReblog < ActiveRecord::Migration
  def change
    add_column :reblogs, :previous_user_id, :integer, null:false
  end
end
