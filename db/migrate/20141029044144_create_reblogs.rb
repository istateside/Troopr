class CreateReblogs < ActiveRecord::Migration
  def change
    create_table :reblogs do |t|
      t.integer :source_id, null:false
      t.integer :reblogger_id, null:false
      t.integer :post_id, null:false
      t.timestamps
    end
  end
end
