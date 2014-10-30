# == Schema Information
#
# Table name: blogs
#
#  id             :integer          not null, primary key
#  blogname       :string(255)      not null
#  user_id        :integer          not null
#  description    :text             not null
#  location       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  filepicker_url :string(255)
#

class Blog < ActiveRecord::Base
  belongs_to :user  
  
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  
  has_many :posts, dependent: :destroy
  
  has_many :own_reblogs,
    class_name: "Reblog",
    foreign_key: :blog_id,
    inverse_of: :reblogger

  has_many :others_reblogs,
    class_name: "Reblog",
    foreign_key: :previous_blog_id,
    source: :previous_blog
    
  has_many :reblogged_posts, 
    through: :own_reblogs
    
  has_many :follows,
    class_name: "Follow",
    foreign_key: "source_id",
    dependent: :destroy  

  has_many :following, through: :follows, source: :target
  has_many :followers, through: :follows, source: :source
  
  
  def is_following?(blog)
    self.following.include?(blog)
  end
  
  def has_liked?(post)
    self.liked_posts.include?(post)
  end
  
  
end
