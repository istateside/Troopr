# = Schema Information
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


class Blog < ActiveRecord::Base
  AVATAR_DEFAULTS= [
    'https://www.filepicker.io/api/file/4jnwDuuUSo6nx0RgkaHN',
    'https://www.filepicker.io/api/file/sTX6eUk1Tqq6UxIWtiB0',
    'https://www.filepicker.io/api/file/MGh0U0GWRDa8HLKvteJ0',
    'https://www.filepicker.io/api/file/0MqJ0DtzSz6QaYI1h7CG',
    'https://www.filepicker.io/api/file/WdIeC3i1QXiFN9fDaQX1',
    'https://www.filepicker.io/api/file/2bDOO6xVRpqbGEaz8UEP',
    'https://www.filepicker.io/api/file/OTpSnIKZRheksHULnnXn',
    'https://www.filepicker.io/api/file/RxffJqDTSCyw4R7hgQwj'
  ]

  before_save :check_filepicker
  validates :blogname,
    length: {
      in: 6..20, wrong_length: "Blogname must be between 6-20 characters"
      },
    format: { without: /\s/, message: "No spaces in blognames, please!" }

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

  has_many :own_follows,
    class_name: "Follow",
    foreign_key: "source_id",
    dependent: :destroy

  has_many :others_follows,
    class_name: "Follow",
    foreign_key: "target_id",
    dependent: :destroy

  has_many :following, through: :own_follows, source: :target
  has_many :followers, through: :others_follows, source: :source

  def check_filepicker
    if self.filepicker_url.blank?
      self.filepicker_url = AVATAR_DEFAULTS.sample
    end
  end

  def is_following?(blog)
    self.following.include?(blog)
  end

  def has_liked?(post)
    self.liked_posts.include?(post)
  end


end
