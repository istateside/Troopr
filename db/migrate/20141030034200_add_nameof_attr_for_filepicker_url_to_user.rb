class AddNameofAttrForFilepickerUrlToUser < ActiveRecord::Migration
  def change
    add_column :blogs, :filepicker_url, :string
  end
end
