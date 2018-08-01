require 'rails_helper'

describe MatchChannel, type: :channel do
  let(:user) { create(:user) }
  let(:target) { create(:target, user: user) }
  let(:match) { create(:match, original_target: target) }
  let(:match_id) { match.id }

  before do
    stub_connection(current_user: user)
  end

  describe '#subscribed' do
    context 'when no match id' do
      it "rejects the subscription" do
        subscribe
        expect(subscription).to be_rejected
      end
    end

    context 'when match id is provided' do
      it "subscribes successfully" do
        subscribe(id: match_id)

        expect(subscription).to be_confirmed
        expect(streams).to include("match_#{match_id}_room")
      end
    end
  end

  describe '#unsubscribed' do
    it 'updates the last online date for the user' do
      subscribe(id: match_id)
      subscription.unsubscribe_from_channel
      match.reload
      expect(match.user_a_last_online).to be_within(1.second).of(Time.now)
    end
  end
end
