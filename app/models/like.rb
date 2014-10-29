class Like < ActiveRecord::Base
  validates :post, :user, presence: true
  
  belongs_to :post
  belongs_to :user
end