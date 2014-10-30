# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null
#  username         :string(255)      not null
#  password_digest  :string(255)      not null
#  session_token    :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#  activated        :boolean          default(FALSE)
#  activation_token :string(255)
#

class User < ActiveRecord::Base
  attr_reader :password, :current_blog
  
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank"}
  validates :password, length: { minimum: 6, allow_nil: true }, confirmation: true
  
  after_initialize :ensure_session_token
  
  has_many :blogs
  
  def is_activated?
    self.activated
  end
  
  def current_blog
    @current_blog ||= self.blogs.first
  end
  
  def current_blog=(blog)
    @current_blog = blog
  end
  
  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def reset_session_token
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
  
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
end
