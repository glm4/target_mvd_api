require 'rails_helper'

describe 'GET api/v1/topics/', type: :request do
  describe 'GET index' do
    let(:user) { create(:user) }
    let!(:topic) { create(:topic) }

    it 'returns a successful response' do
      get api_v1_topics_path, headers: auth_headers, as: :json

      expect(response).to have_http_status(:success)
    end

    it 'returns the list of topics' do
      get api_v1_topics_path, headers: auth_headers, as: :json

      expect(json[:topics]).to_not be_empty
      expect(json[:topics].last[:topic][:id]).to eq(topic.id)
      expect(json[:topics].last[:topic][:name]).to eq(topic.name)
    end

    context 'when there is no topics' do
      it 'returns an empty array' do
        Topic.destroy_all
        get api_v1_topics_path, headers: auth_headers, as: :json

        expect(json[:topics]).to be_empty
      end
    end
  end
end
