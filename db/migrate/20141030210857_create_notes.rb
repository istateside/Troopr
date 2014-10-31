class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :text, null:false
      t.integer :post_id, null:false

      t.timestamps
    end
  end
end
