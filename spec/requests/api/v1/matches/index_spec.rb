require 'rails_helper'

describe 'GET api/v1/matches/', type: :request do
  describe 'GET index' do
    let!(:target) { create(:target, :within_range) }
    let(:user) { create(:user, targets: [target]) }
    let!(:topic_id) { target.topic_id }
    let!(:matching_target) { create(:target, :within_range, topic_id: topic_id) }
    let!(:match) { create(:match, original_target: target, matching_target: matching_target) }

    subject do
      get api_v1_matches_path, headers: auth_headers, as: :json
    end

    it 'returns a successful response' do
      subject

      expect(response).to have_http_status(:success)
    end

    context 'when the user has matching targets' do
      it 'returns the list of matches' do
        subject

        expect(json[:matches]).to_not be_empty
        expect(json[:matches].map { |t| t[:original_target][:id] }).to include(target.id)
        expect(json[:matches].map { |t| t[:matching_target][:id] }).to include(matching_target.id)
      end
    end

    context 'when there is no matches' do
      it 'returns an empty array' do
        user.targets.destroy_all
        subject

        expect(json[:matches]).to be_empty
      end
    end
  end
end
