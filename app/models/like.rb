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
  validates :post, :user, presence: true
  validates_uniqueness_of :user_id, :scope => [:post_id]
  
  belongs_to :post
  belongs_to :user
  
  def render
    return (self.user.username + " liked this post.")
  end
end
