# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  body             :text             not null
#  user_id          :integer          not null
#  post_type        :string(255)      not null
#  url              :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  reblog           :boolean          default(FALSE)
#  previous_user_id :integer
#  original_post_id :integer
#

class Post < ActiveRecord::Base
  attr_accessor :notes
  validates :blog, :body, :post_type, :blog_id, presence: true

  belongs_to :blog 
  belongs_to :previous_blog,
    class_name: "Blog",
    foreign_key: :previous_blog_id,
    primary_key: :id    
  
  belongs_to :original_post,
    class_name: "Post",
    foreign_key: :original_post_id

  has_many :likes
  
  has_many :reblogs
  
  has_many :descendents,
    class_name: "Post",
    foreign_key: :original_post_id

  def self.original_source(post)
    !post.reblog ? (return post) : (return Post.original_source(post.original_post))
  end
  
  def get_notes
    self.notes ||= []
  end  
  
  def get_actions
    !reblog ? (return (self.likes + self.reblogs)) : (return Post.original_source(self).get_actions)
  end
  
  def get_note_path
    self.notes = []
    get_actions.each do |action|
      self.get_notes << action.render
    end
    return self.get_notes
  end
end
