# == Schema Information
#
# Table name: reblogs
#
#  id      :integer          not null, primary key
#  post_id :integer          not null
#  user_id :integer          not null
#

require 'rails_helper'

RSpec.describe Reblog, :type => :model do

  it { should belong_to(:post) }
  it { should belong_to(:user) }
end
