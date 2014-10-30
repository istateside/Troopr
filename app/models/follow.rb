# == Schema Information
#
# Table name: follows
#
#  id         :integer          not null, primary key
#  source_id  :integer          not null
#  target_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Follow < ActiveRecord::Base
  validates_presence_of :source_id, :target_id
  validates_uniqueness_of :source_id, :scope => [:target_id]
  validates :source, :target, presence: true
  
  belongs_to :source, class_name: "Blog", foreign_key: :source_id, primary_key: :id
  belongs_to :target, class_name: "Blog", foreign_key: :target_id, primary_key: :id
end
