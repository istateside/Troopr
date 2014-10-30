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
#

require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:blogs) }
  it { should belong_to(:current_blog) }
  
  
end
