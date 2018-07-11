require 'rails_helper'

describe Api::V1::TargetsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/targets').to route_to('api/v1/targets#index', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/api/v1/targets').to route_to('api/v1/targets#create', format: :json)
    end
  end
end
