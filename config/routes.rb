Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount_devise_token_auth_for 'User', at: '/api/v1/users', controllers: {
    registrations:  'api/v1/registrations',
    sessions:  'api/v1/sessions',
    passwords:  'api/v1/passwords'
  }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      devise_scope :user do
        get :status, to: 'api#status'
        resources :users, only: :show
        resources :topics, only: :index
        resources :matches, only: :index do
          resources :messages, only: %i[index , create]
        end
        resources :targets
        resource :user, only: :update do
          get :profile
        end
      end
    end
  end
end
