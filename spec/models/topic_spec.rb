# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :string
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'validations' do
    subject { build :topic }
    it { should validate_presence_of(:name) }
  end
end
