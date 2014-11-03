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
  
  def render
    case self.notable_type
    when 'Like'
       "#{self.notable.blog.blogname} liked this.".html_safe
    when 'Reblog'
      "#{self.notable.reblogger.blogname} reblogged this from #{self.notable.previous_blog.blogname}".html_safe
    when 'Post'
      "#{self.notable.blog.blogname} posted this.".html_safe
    end
  end
end
