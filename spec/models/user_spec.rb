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

require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:follows) }
  it { should have_many(:likes) }
  it { should have_many(:liked_posts) }
  it { should have_many(:reblogs) }
  it { should have_many(:posts) }
  it { should have_many(:following) }
  it { should have_many(:followers) }
end
