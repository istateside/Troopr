# == Schema Information
#
# Table name: likes
#
#  id               :integer          not null, primary key
#  blog_id          :integer          not null
#  post_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  original_post_id :integer
#

class Like < ActiveRecord::Base
  validates :post, :blog, presence: true
  validates_uniqueness_of :blog_id, :scope => [:post_id]
  
  belongs_to :post
  belongs_to :blog
  belongs_to :original_post, class_name: "Post", foreign_key: :original_post_id
  has_one :note, as: :notable, dependent: :destroy
  def render
    return (self.blog.blogname + " liked this post.")
  end
end
