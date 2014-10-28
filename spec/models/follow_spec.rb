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

# FactoryGirl.define do
#   factory :follow do |f|
#     p.source_id 1
#     p.target_id 2
#   end
# end

RSpec.describe Follow, :type => :model do
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
        john = User.create!({email: "john@test.com", password: "testtest"})
        User.create!({email: "mary@test.com", password: "testtest"})
        User.create!({email: "steve@test.com", password: "testtest"})
        Follow.create!({source_id: 1, target_id: 2})
        Follow.create!({source_id: 1, target_id: 3})      
        Follow.create!({source_id: 3, target_id: 1})
        expect(john.followers.length).to eq(2)
      end
    end   
    
    context "#following" do
      it "returns an array of users that the specified user is following"
    end
    
    it "is deleted when either user is deleted"
  end
end
