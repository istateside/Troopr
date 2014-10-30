class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :blogname, null:false, unique:true
      t.integer :user_id, null:false
      t.text :description, null:false      
      t.string :location            
                                    
      t.timestamps
    end
  end
end
