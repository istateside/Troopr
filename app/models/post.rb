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

  validates :blog, :post_type, :blog_id, presence: true
  validate :type_checks

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

  paginates_per 10

  def type_checks
    case self.post_type
    when 'text'
      return false if self.title.blank? && self.body.blank?
    when 'audio'
      return false if self.url.blank?
    when 'photo'
      return false if self.url.blank?
    when 'quote'
      return false if self.body.blank? && self.title.blank?
    when 'link'
      return false if self.url.blank?
    when 'chat'
      return false if self.body.blank?
    when 'video'
      return false if self.url.blank?
    end
    return true
  end

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

  def parsedBody
    lines = self.body.gsub("\r","").split("\n")
    parsedLines = []

    lines.each do |line|
      parsedGroups = line.match(/(\w+:) (.+)/)
      speaker = parsedGroups[1]
      speech = parsedGroups[2]

      parsedLine =
        "<p class='chatLine'><strong>#{speaker} \t</strong>#{speech}</p>"
      .html_safe
      parsedLines << parsedLine
    end

    return parsedLines.join("<br>".html_safe).html_safe
  end
end
