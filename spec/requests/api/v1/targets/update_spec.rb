require 'rails_helper'

describe 'PUT api/v1/targets/:id', type: :request do
  let!(:target) { create(:target) }
  let(:user) { create(:user, targets: [target]) }
  let!(:target_id) { target.id }

  describe 'PUT update' do
    let!(:topic) { create(:topic) }
    let(:radius) { 200 }
    let(:lat) { 10 }
    let(:lng) { -10 }

    let(:params) do
      {
        radius: radius,
        lat: lat,
        lng: lng,
        topic_id: topic.id
      }
    end

    subject do
      put api_v1_target_path(target_id), headers: auth_headers, params: params, as: :json
    end

    context 'when the target exists' do
      it 'returns a successful response' do
        subject

        expect(response).to have_http_status(:success)
      end

      it 'updates the target correctly' do
        subject

        expect(json[:target][:radius]).to eq(radius)
        expect(json[:target][:lat]).to eq(lat)
        expect(json[:target][:lng]).to eq(lng)
        expect(json[:target][:topic][:id]).to eq(topic.id)
      end
    end

    context 'when no target exists' do
      let(:target_id) { 0 }

      it 'does NOT return a successful response' do
        subject

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
