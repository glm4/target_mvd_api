require 'rails_helper'

describe 'POST api/v1/targets/', type: :request do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:failed_response) { 400 }

  describe 'POST create' do
    let(:title)    { 'Test Target' }
    let(:lat)      { -58.1389130123 }
    let(:lng)      { 34.9021387344 }
    let(:radius)   { 100.5 }
    let(:topic_id) { topic.id }

    let(:params) do
      {
        target: {
          title: title,
          lat: lat,
          lng: lng,
          radius: radius,
          topic_id: topic_id
        }
      }
    end

    def request_create_target
      post api_v1_targets_path, params: params, headers: auth_headers, as: :json
    end

    it 'returns a successful response' do
      request_create_target

      expect(response).to have_http_status(:success)
    end

    it 'creates the target correctly' do
      expect do
        request_create_target
      end.to change(Target, :count).by(1)
    end

    it 'returns the recently created target' do
      request_create_target

      expect(json[:target][:title]).to eq(title)
      expect(json[:target][:lat]).to be_within(0.01).of(lat)
      expect(json[:target][:lng]).to be_within(0.01).of(lng)
      expect(json[:target][:radius]).to eq(radius)
      expect(json[:target][:topic]).to_not be_nil
      expect(json[:target][:topic][:id]).to eq(topic_id)
    end

    context 'when the topic does not exist' do
      let(:topic_id) { 0 }

      it 'does not create a target' do
        expect do
          request_create_target
        end.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        request_create_target

        expect(response.status).to eq(failed_response)
      end
    end
  end
end
