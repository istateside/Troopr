# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null
#  password_digest  :string(255)      not null
#  session_token    :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#  activated        :boolean          default(FALSE)
#  activation_token :string(255)
#  current_blog_id  :integer

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :password, :current_blog

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank"}
  validates :password, length: { minimum: 6, allow_nil: true }, confirmation: true

  after_initialize :ensure_session_token

  has_many :blogs

  def is_activated?
    self.activated
  end

  def current_active_blog
    if self.current_blog_id.nil?
      current_active_blog=(self.blogs.first)
    else
      self.blogs.find(self.current_blog_id)
    end
  end

  def current_active_blog=(id)
    self.current_blog_id = id
    self.save!
  end

  def self.find_or_create_by_fb_auth_hash(auth_hash)
    @user = User.find_by_email(auth_hash[:info][:email])
    @user = User.new({email: auth_hash[:info][:email]}) if @user.nil?
    return @user
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
