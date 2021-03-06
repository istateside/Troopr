# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  body             :text             not null
#  blog_id          :integer          not null
#  post_type        :string(255)      not null
#  url              :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  reblog           :boolean          default(FALSE)
#  previous_blog_id :integer
#  original_post_id :integer
#  filepicker_url   :string(255)
#

require 'rails_helper'

FactoryGirl.define do
  factory :post do |p|
    p.title "Test post"
    p.body "This is a new post to test"
    p.post_type "text"
    p.user_id 1
  end
end

RSpec.describe Post, :type => :model do
  context "associations" do
    it { should belong_to(:blog) }
    it { should belong_to(:previous_blog) }
    it { should have_many(:likes) }
  end
  
  
  context "without title, body or type" do 
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

  context "with Blogs" do
    before(:each) do

    end
  end
end
