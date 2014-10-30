# == Schema Information
#
# Table name: reblogs
#
#  id               :integer          not null, primary key
#  post_id          :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  previous_user_id :integer          not null
#

class Reblog < ActiveRecord::Base
  belongs_to :post
  
  belongs_to :reblogger,
    class_name: "Blog",
    foreign_key: :blog_id,
    inverse_of: :own_reblogs
  
  belongs_to :previous_blog,
    class_name: "Blog",
    foreign_key: :previous_blog_id,
    inverse_of: :others_reblogs
    
  def render
    return (self.reblogger.blogname + " reblogged this from " + self.previous_blog.blogname)
  end
end
