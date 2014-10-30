# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  body             :text             not null
#  blog_id          :integer          not null
#  post_type        :string(255)      not null
#  url              :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  reblog           :boolean          default(FALSE)
#  previous_blog_id :integer
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
  
  has_many :reblogs,
    class_name: "Reblog",
    foreign_key: :previous_post_id,
    primary_key: :id,
    inverse_of: :previous_post
    
  has_one :past_reblog,
    class_name: "Reblog",
    foreign_key: :new_post_id,
    primary_key: :id,
    inverse_of: :new_post
  
  has_many :descendents, through: :reblogs, source: :new_post
    
  def all_children
    all_children = []
    puts all_children
    puts self.descendents
    puts self
    all_children << self.descendents << self
    
    self.descendents.each do |child|
      all_children += child.descendents
    end
    return all_children.flatten
  end  
    
  def self.original_source(post)
    !post.reblog ? (return post) : (return Post.original_source(post.original_post))
  end
  
  def get_actions
    actions = []
    source = Post.original_source(self)
    posts = source.all_children
    posts.each do |post|
      actions.push(post.likes + post.reblogs)
    end
    
    return actions.flatten
  end
  
  def get_notes(actions)
    notes = []
    actions.each do |action|
      notes << {msg: action.render, time: action.created_at}
    end
    
    return notes
  end  
  
  def get_note_path
    notes = get_notes(self.get_actions)
    notes = notes.sort_by {|note| note[:time]}
    notes.map! { |note| note[:msg] }
    notes.push(Post.original_source(self).blog.blogname + " posted this.")
    return notes.reverse    
  end
end
