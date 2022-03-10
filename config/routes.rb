Rails.application.routes.draw do
  # devise_for :users
  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
  resources :accounts,only:[:create,:destroy,:show]
  resources :tweets,only:[:destroy,:update,:create,:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end