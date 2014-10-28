class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, unique:true, null:false
      t.string :username, unique:true, null:false
      t.string :password_digest, null:false
      t.string :session_token, null:false

      t.timestamps
    end
    
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_index :users, :session_token
  end
end
