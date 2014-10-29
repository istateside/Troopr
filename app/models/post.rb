# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  body       :text             not null
#  user_id    :integer          not null
#  post_type  :string(255)      not null
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :body, :post_type, :user_id, presence: true

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :tags, dependent: :destroy
end
