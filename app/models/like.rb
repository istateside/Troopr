# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  post_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Like < ActiveRecord::Base
  validates :post, :blog, presence: true
  validates_uniqueness_of :blog_id, :scope => [:post_id]
  
  belongs_to :post
  belongs_to :blog
  
  def render
    return (self.blog.blogname + " liked this post.")
  end
end
