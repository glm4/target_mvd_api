require 'rails_helper'

describe 'DELETE api/v1/targets/:id', type: :request do
  let!(:target) { create(:target) }
  let(:user) { create(:user, targets: [target]) }
  let!(:target_id) { target.id }

  describe 'DELETE destroy' do
    subject do
      delete api_v1_target_path(target_id), headers: auth_headers, as: :json
    end

    context 'when a valid record exists' do
      it 'returns a successful response' do
        subject

        expect(response).to have_http_status(:success)
      end

      it 'deletes the target' do
        expect { subject }.to change(Target, :count).by(-1)
      end

      it 'removes the target from the user' do
        subject

        user.reload
        expect(user.targets.ids).to_not include(target_id)
      end
    end

    context 'when no record exists' do
      let(:target_id) { 0 }

      it 'does NOT return a successful response' do
        subject

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
