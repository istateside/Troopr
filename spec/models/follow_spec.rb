# == Schema Information
#
# Table name: follows
#
#  id         :integer          not null, primary key
#  source_id  :integer          not null
#  target_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'
require 'factory_girl'
require 'shoulda-matchers'

RSpec.describe Follow, :type => :model do
  
  it { should belong_to(:source) }
  it { should belong_to(:target) }
  context "validations" do
    it "user cannot follow another user twice" do
      
    end
    
    it "must specify a source and target user" do
      # expect(FactoryGirl.build(:follow, target_id: nil)).to_not be_valid
    end
  end
  
  context "with Users" do   
    context "#followers" do
      before(:each) do
       
      end
      
      it "returns an array" do
        # john = User.new({id: 1, email: "john@test.com", password: "testtest"})
        # User.new({id: 2, email: "mary@test.com", password: "testtest"})
        # User.new({id: 3, email: "steve@test.com", password: "testtest"})
        # Follow.new({source_id: 1, target_id: 2})
        # Follow.new({source_id: 1, target_id: 3})
        # Follow.new({source_id: 3, target_id: 1})
        # expect(john.followers.length).to eq(2)
      end
    end   
    
    context "#following" do
      it "returns an array of users that the specified user is following" do
        # expect(john.following.class).to eq(Array)
      end
    end
    
    it "is deleted when either user is deleted"
  end
end
