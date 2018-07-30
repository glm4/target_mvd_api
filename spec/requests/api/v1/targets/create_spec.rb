require 'rails_helper'

describe 'POST api/v1/targets/', type: :request do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }

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

    subject do
      post api_v1_targets_path, params: params, headers: auth_headers, as: :json
    end

    context 'when the topic exists' do
      it 'returns a successful response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'creates the target correctly' do
        expect { subject }.to change(Target, :count).by(1)
      end

      it 'returns the recently created target' do
        subject
        expect(json[:target][:title]).to eq(title)
        expect(json[:target][:lat]).to be_within(0.01).of(lat)
        expect(json[:target][:lng]).to be_within(0.01).of(lng)
        expect(json[:target][:radius]).to eq(radius)
        expect(json[:target][:topic]).to_not be_nil
        expect(json[:target][:topic][:id]).to eq(topic_id)
      end

      it 'adds the target to the user targets' do
        subject

        expect(user.targets.ids).to include(json[:target][:id])
      end

      context 'when there are matching targets' do
        let!(:original_target) { create(:target, lat: lat, lng: lng, topic_id: topic_id) }

        it 'creates a match' do
          expect { subject }.to change(Match, :count).by(1)
        end

        it 'adds the match to the target' do
          subject

          target = Target.find(json[:target][:id])
          expect(target.reverse_matches).to_not be_empty
          expect(target.reverse_matches.last.original_target).to eq(original_target)
        end
      end

      context 'when there are NO matching targets' do
        it 'does NOT create a match' do
          expect { subject }.to_not change(Match, :count)
        end
      end
    end

    shared_examples 'unchanged target list' do
      it 'does NOT create a target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does NOT return a successful response' do
        subject

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the topic does not exist' do
      let(:topic_id) { 0 }

      include_examples 'unchanged target list'
    end

    context 'when the user has too many targets' do
      let!(:user) { create(:user, targets: create_list(:target, Target::PER_USER_LIMIT)) }

      include_examples 'unchanged target list'
    end
  end
end
