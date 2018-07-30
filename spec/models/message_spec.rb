# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  match_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    subject { build :message }
    it { should validate_presence_of(:match) }
    it { should validate_presence_of(:user) }
    it 'validates that the match belongs to the user' do
      subject.match = create(:match)
      subject.valid?
      expect(subject.errors[:user]).to include(I18n.t('api.errors.match_access_forbidden'))
    end
  end
end
