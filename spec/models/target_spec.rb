# == Schema Information
#
# Table name: targets
#
#  id         :integer          not null, primary key
#  title      :string
#  lat        :decimal(, )
#  lng        :decimal(, )
#  radius     :decimal(, )
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'rails_helper'

RSpec.describe Target, type: :model do
  describe 'validations' do
    subject { build :target }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lng) }
    it { should validate_presence_of(:radius) }
    it { should validate_presence_of(:topic) }
  end
end
