class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null:false
      t.text :body, null:false
      t.integer :user_id, null:false
      t.string :type, null:false
      t.string :url

      t.timestamps
    end
  end
end
