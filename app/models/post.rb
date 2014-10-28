class Post < ActiveRecord::Base
  validates :title, :body, :post_type, :user_id, presence: true

  belongs_to :user
  has_many :tags
end
