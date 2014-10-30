# == Schema Information
#
# Table name: blogs
#
#  id          :integer          not null, primary key
#  blogname    :string(255)      not null
#  user_id     :integer          not null
#  description :text             not null
#  location    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Blog, :type => :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:likes) }  
    it { should have_many(:liked_posts) }  
    it { should have_many(:posts) }  
    it { should have_many(:own_reblogs) }  
    it { should have_many(:others_reblogs) }  
    it { should have_many(:follows) }
    it { should have_many(:following) }  
    it { should have_many(:followers) }    
  end
end
