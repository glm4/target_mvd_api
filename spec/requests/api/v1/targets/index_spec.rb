require 'rails_helper'

describe 'GET api/v1/targets/', type: :request do
  describe 'GET index' do
    let (:params) { { lat: -34.9, lng: -56.2 } }
    let!(:target) { create(:target, :within_range, origin: params) }
    let!(:far_away_target) { create(:target, :out_of_range, origin: params) }
    let(:user) { create(:user, targets: [target, far_away_target]) }

    subject do
      get api_v1_targets_path, headers: auth_headers, params: params, as: :json
    end

    context 'when origin location is not provided' do
      it 'does not return a successful response' do
        get api_v1_targets_path, headers: auth_headers, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when a valid origin location is provided' do
      it 'returns a successful response' do
        subject

        expect(response).to have_http_status(:success)
      end

      context 'when there are targets' do
        it 'returns the list of targets within range' do
          subject

          expect(json[:targets]).to_not be_empty
          expect(json[:targets].map { |t| t[:id] }).to include(target.id)
          expect(json[:targets].last[:id]).to eq(target.id)
          expect(json[:targets].last[:title]).to eq(target.title)
        end

        it 'does not return targets out of range' do
          subject

          expect(json[:targets].map { |t| t[:id] }).to_not include(far_away_target.id)
        end
      end

      context 'when there is no targets' do
        it 'returns an empty array' do
          user.targets.destroy_all
          subject

          expect(json[:targets]).to be_empty
        end
      end
    end
  end
end
