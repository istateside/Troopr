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
#

class Post < ActiveRecord::Base
  validates :body, :post_type, :user_id, presence: true

  belongs_to :user
  belongs_to :previous_user,
    class_name: "User",
    foreign_key: :previous_user_id,
    primary_key: :id
    
  has_many :likes, dependent: :destroy
  # has_many :tags, dependent: :destroy
  
end
