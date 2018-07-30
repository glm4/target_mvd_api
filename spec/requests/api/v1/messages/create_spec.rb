require 'rails_helper'

describe 'POST api/v1/matches/:match_id/messages', type: :request do
  let(:match) { create(:match) }
  let(:match_id) { match.id }
  let(:user) { create(:user, targets: [match.original_target]) }

  describe 'POST create' do
    let(:content)    { Faker::Hacker.say_something_smart }
    let(:params) do
      {
        message: {
          content: content
        }
      }
    end

    subject do
      post api_v1_match_messages_path(match_id), params: params, headers: auth_headers, as: :json
    end

    context 'when the match exists' do

      it 'returns a successful response' do
        subject

        expect(response).to have_http_status(:success)
      end

      it 'creates the message correctly' do
        expect { subject }.to change(Message, :count).by(1)
      end

      it 'returns the recently created message' do
        subject

        expect(json[:message][:content]).to eq(content)
        expect(json[:message][:user][:id]).to eq(user.id)
        expect(json[:message][:match_id]).to eq(match_id)
      end

      it 'adds the message to the user' do
        subject

        expect(user.messages.ids).to include(json[:message][:id])
      end
    end

    shared_examples 'unchanged message list' do
      it 'does NOT create a message' do
        expect { subject }.not_to change { Message.count }
      end

      it 'does NOT return a successful response' do
        subject

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the match does not exist' do
      let(:match_id) { 0 }

      include_examples 'unchanged message list'
    end

    context 'when the match does NOT belong to the current user' do
      let(:match_id) { create(:match).id }

      include_examples 'unchanged message list'
    end
  end
end
