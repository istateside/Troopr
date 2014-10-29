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

RSpec.describe Follow, :type => :model do
  
  it { should belong_to(:source) }
  it { should belong_to(:target) }
  
  context "with Users" do   
    context "#followers" do
      
      it "returns an array" do
      end
    end   
    
    context "#following" do
      it "returns an array of users that the specified user is following" do
      end
    end
    
    it "is deleted when either user is deleted"
  end
end
