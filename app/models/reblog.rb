# == Schema Information
#
# Table name: reblogs
#
#  id      :integer          not null, primary key
#  post_id :integer          not null
#  user_id :integer          not null
#

class Reblog < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
end
