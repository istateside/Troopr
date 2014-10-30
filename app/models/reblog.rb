# == Schema Information
#
# Table name: reblogs
#
#  id               :integer          not null, primary key
#  new_post_id      :integer          not null
#  blog_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  previous_blog_id :integer          not null
#  previous_post_id :string(255)
#

class Reblog < ActiveRecord::Base
  belongs_to :reblogger,         
    class_name: "Blog",          
    foreign_key: :blog_id,       
    inverse_of: :own_reblogs     
                                 
  belongs_to :previous_blog,     
    class_name: "Blog",          
    foreign_key: :previous_blog_id,
    inverse_of: :others_reblogs  
                                 
  belongs_to :previous_post,     
    class_name: "Post",          
    foreign_key: :previous_post_id,
    inverse_of: :reblogs         
                                 
  belongs_to :new_post,
    class_name: "Post",
    foreign_key: :new_post_id,
    primary_key: :id
  
  def render
    return (self.reblogger.blogname + " reblogged this from " + self.previous_blog.blogname)
  end
end
