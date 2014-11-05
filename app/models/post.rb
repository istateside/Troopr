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
#  filepicker_url   :string(255)
#

class Post < ActiveRecord::Base
  before_destroy :destroy_reblog_note
  after_create :set_original_post_id
  
  validates :blog, :body, :post_type, :blog_id, presence: true

  belongs_to :blog 
  
  belongs_to :previous_blog,
    class_name: "Blog",
    foreign_key: :previous_blog_id,
    primary_key: :id    
  
  belongs_to :original_post,
    class_name: "Post",
    foreign_key: :original_post_id

  has_many :likes, dependent: :destroy
  
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
    
  has_one :note, as: :notable, dependent: :destroy
  
  has_many :descendents, through: :reblogs, source: :new_post
  
  def set_original_post_id
    if !self.reblog
      self.original_post_id = self.id
      self.save!
    end
  end
  
  def get_notes
    return Note.where("original_post_id = ?", self.original_post_id).order(created_at: :desc)
  end
  
  def destroy_reblog_note
    self.past_reblog.note.destroy! if (!!self.reblog && !!self.past_reblog)
  end
end
