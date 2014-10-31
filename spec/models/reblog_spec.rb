# == Schema Information
#
# Table name: reblogs
#
#  id               :integer          not null, primary key
#  new_post_id      :integer          not null
#  blog_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  previous_blog_id :integer          not null
#  previous_post_id :string(255)
#  original_post_id :integer          not null
#

require 'rails_helper'

RSpec.describe Reblog, :type => :model do
  it { should belong_to(:post) }
  it { should belong_to(:reblogger) }
  it { should belong_to(:previous_blog) }
  
  describe "#render" do
    it "returns a string describing the interaction"
  end
end
