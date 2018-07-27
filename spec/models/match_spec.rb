# == Schema Information
#
# Table name: matches
#
#  id                 :integer          not null, primary key
#  last_message       :string
#  unread_messages    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  original_target_id :integer          not null
#  matching_target_id :integer          not null
#

require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'validations' do
    subject { build :match }
    it { should validate_presence_of(:original_target) }
    it { should validate_presence_of(:matching_target) }
  end
end
