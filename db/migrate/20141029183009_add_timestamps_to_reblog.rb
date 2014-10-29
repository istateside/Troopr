class AddTimestampsToReblog < ActiveRecord::Migration
  def change
    add_column(:reblogs, :created_at, :datetime)
    add_column(:reblogs, :updated_at, :datetime)
  end
end
