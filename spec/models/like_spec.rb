# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  post_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Like, :type => :model do
  it { should belong_to(:post) }
  it { should belong_to(:user) }
end
