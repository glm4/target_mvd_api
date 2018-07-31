require 'rails_helper'

describe 'GET api/v1/matches/:match_id/messages', type: :request do
  describe 'GET index' do
    let(:target) { create(:target) }
    let(:user) { target.user }
    let(:matching_target) { create(:target) }
    let(:match) { create(:match, original_target: target, matching_target: matching_target) }
    let(:match_id) { match.id }
    let!(:message) { create(:message, user: user, match: match) }
    let(:message_id) { message.id }

    subject do
      get api_v1_match_messages_path(match_id), headers: auth_headers, as: :json
    end

    context 'when the match exists' do
      it 'returns a successful response' do
        subject

        expect(response).to have_http_status(:success)
      end

      context 'when the user has messages for the match' do
        it 'returns the list of messages' do
          subject

          expect(json[:messages]).to_not be_empty
          expect(json[:messages].map { |t| t[:id] }).to include(message_id)
        end
      end
    end

    context 'when there is no messages' do
      it 'returns an empty array' do
        match.messages.destroy_all
        subject

        expect(json[:messages]).to be_empty
      end
    end

    context 'when the match does NOT exist' do
      let(:match_id) { 0 }

      it 'does NOT return a successful response' do
        subject

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
