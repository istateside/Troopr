class AddPreviousPostIdToReblogs < ActiveRecord::Migration
  def change
    add_column :reblogs, :previous_post_id, :string
  end
end
