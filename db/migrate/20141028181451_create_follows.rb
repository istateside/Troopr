class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :source_id, null:false
      t.integer :target_id, null:false

      t.timestamps
    end
    
    add_index :follows, [:source_id, :target_id], :unique => true
  end
end
