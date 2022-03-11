Rails.application.routes.draw do
  # devise_for :users
  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
  resources :accounts,only:[:create,:destroy]
  resources :tweets,only:[:destroy,:update,:create,:index]
  get "user/followers",to: "accounts#followers"
  get "user/following",to: "accounts#following"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
