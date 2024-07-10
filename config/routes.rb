Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  devise_for :users, skip: :all, defaults: { format: 'json' }, path: 'api/v1', skip: :sessions

  as :user do
    post 'api/v1/sign_in' => 'api/v1/sessions#create', as: :session_sign_in
    delete 'api/v1/sign_out' => 'api/v1/sessions#destroy', as: :session_sign_out
    post 'api/v1/sign_up' => 'api/v1/registrations#create', as: :session_sign_up
  end

  namespace 'api', constraints: { format: 'json' } do
    namespace 'v1' do
      resources :users
    end
  end
end
