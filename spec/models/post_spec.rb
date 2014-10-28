# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  body       :text             not null
#  user_id    :integer          not null
#  post_type  :string(255)      not null
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'
require 'factory_girl'
FactoryGirl.define do
  factory :post do |p|
    p.title "Test post"
    p.body "This is a new post to test"
    p.post_type "text"
    p.user_id 1
  end
end

RSpec.describe Post, :type => :model do
  context "without title, body or type" do 

    it "validates presence of title" do
      expect(FactoryGirl.build(:post, title: nil)).to_not be_valid
    end

    it "validates presence of body" do
      expect(FactoryGirl.build(:post, body: nil)).to_not be_valid
    end

    it "validates presence of type" do
      expect(FactoryGirl.build(:post, post_type: nil)).to_not be_valid
    end
  end

  context "valid post" do
    it "accepts a valid model with title, body, and type" do
      expect(FactoryGirl.build(:post)).to be_valid
    end
  end

  context "with users" do
    before(:each) do

    end
  end
end
