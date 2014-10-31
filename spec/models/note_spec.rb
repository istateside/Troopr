# == Schema Information
#
# Table name: notes
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  original_post_id :integer          not null
#  notable_id       :integer          not null
#  notable_type     :string(255)      not null
#

require 'rails_helper'

RSpec.describe Note, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
