class ChangePresenceValidationsOnPost < ActiveRecord::Migration
  def change
    change_column :posts, :body, :text, :null => true
  end
end
