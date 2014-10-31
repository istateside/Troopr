# == Schema Information
#
# Table name: notes
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  original_post_id :integer          not null
#  notable_id       :integer          not null
#  notable_type     :string(255)      not null
#

class Note < ActiveRecord::Base  
  belongs_to :original_post, class_name: "Post", foreign_key: :original_post_id
  
  belongs_to :notable, polymorphic: true
end
