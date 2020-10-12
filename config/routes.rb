Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  get 'admin/index', as: "admin"
  resources :extra_fees
  resources :payments
  resources :loans
  resources :statuses
  resources :moneylenders
  resources :loan_types
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "admin#index"
end
