require 'rails_helper'

describe 'GET api/v1/targets/', type: :request do
  describe 'GET index' do
    let(:user) { create(:user) }
    let!(:target) { create(:target) }

    it 'returns a successful response' do
      get api_v1_targets_path, headers: auth_headers, as: :json

      expect(response).to have_http_status(:success)
    end

    it 'returns the list of targets' do
      get api_v1_targets_path, headers: auth_headers, as: :json

      expect(json[:targets]).to_not be_empty
      expect(json[:targets].last[:target][:id]).to eq(target.id)
      expect(json[:targets].last[:target][:title]).to eq(target.title)
    end

    context 'when there is no targets' do
      it 'returns an empty array' do
        Target.destroy_all
        get api_v1_targets_path, headers: auth_headers, as: :json

        expect(json[:targets]).to be_empty
      end
    end
  end
end
