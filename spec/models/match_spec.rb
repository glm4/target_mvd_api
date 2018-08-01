# == Schema Information
#
# Table name: matches
#
#  id                 :integer          not null, primary key
#  last_message       :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  original_target_id :integer          not null
#  matching_target_id :integer          not null
#  user_a_last_online :datetime         default(Tue, 31 Jul 2018 14:25:06 UTC +00:00), not null
#  user_b_last_online :datetime         default(Tue, 31 Jul 2018 14:25:06 UTC +00:00), not null
#

require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'validations' do
    subject { build :match }
    it { should validate_presence_of(:original_target) }
    it { should validate_presence_of(:matching_target) }
  end
end
