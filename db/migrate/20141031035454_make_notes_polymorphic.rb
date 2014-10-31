class MakeNotesPolymorphic < ActiveRecord::Migration
  def change
    add_column :notes, :notable_id, :integer, null:false
    add_column :notes, :notable_type, :string, null:false
    
    add_index :notes, :notable_id
    add_index :notes, :notable_type
  end
end
