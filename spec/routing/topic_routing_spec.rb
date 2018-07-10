require 'rails_helper'

describe Api::V1::TopicsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/topics').to route_to('api/v1/topics#index', format: :json)
    end
  end
end
