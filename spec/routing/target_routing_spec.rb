require 'rails_helper'

describe Api::V1::TargetsController, type: :routing do
  describe 'routing' do
    let(:path) { '/api/v1/targets' }
    it 'routes to #show' do
      expect(get: "#{path}/1").to route_to('api/v1/targets#show', format: :json, id: '1')
    end

    it 'routes to #index' do
      expect(get: path).to route_to('api/v1/targets#index', format: :json)
    end

    it 'routes to #create' do
      expect(post: path).to route_to('api/v1/targets#create', format: :json)
    end

    it 'routes to #update' do
      request_url = "#{path}/1"
      controller_action = 'api/v1/targets#update'
      expect(put: request_url).to route_to(controller_action, format: :json, id: '1')
      expect(patch: request_url).to route_to(controller_action, format: :json, id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: "#{path}/1").to route_to('api/v1/targets#destroy', format: :json, id: '1')
    end
  end
end
