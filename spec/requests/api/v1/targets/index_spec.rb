require 'rails_helper'

describe 'GET api/v1/targets/', type: :request do
  describe 'GET index' do
    let(:user) { create(:user) }
    let!(:target) do
      target = create(:target)
      user.targets << target
      return target
    end

    subject do
      get api_v1_targets_path, headers: auth_headers, as: :json
    end

    context 'when there are targets' do
      it 'returns a successful response' do
        subject

        expect(response).to have_http_status(:success)
      end

      it 'returns the list of targets of the user' do
        subject

        expect(json[:targets]).to_not be_empty
        expect(json[:targets].map { |t| t[:id] }).to eq(user.targets.ids)
        expect(json[:targets].last[:id]).to eq(target.id)
        expect(json[:targets].last[:title]).to eq(target.title)
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
