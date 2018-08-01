require 'rails_helper'

describe ApplicationCable::Connection, type: :channel do
  describe '#connect' do
    context 'when user is authenticated' do
      let(:user) { create(:user) }

      it 'accepts the connection' do
        expect { connect '/cable', headers: auth_headers }.to_not raise_error
      end
    end

    context 'when user is not authenticated' do
      it 'rejects the connection' do
        expect { connect }.to have_rejected_connection
      end
    end
  end
end
