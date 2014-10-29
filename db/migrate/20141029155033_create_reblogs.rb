class CreateReblogs < ActiveRecord::Migration
  def change
    create_table :reblogs do |t|
      t.integer :post_id, null:false
      t.integer :user_id, null:false
    end
  end
end
