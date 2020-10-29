Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  namespace :admin do
    get 'index', as: "index"
    resources :extra_fees
    resources :payments
    resources :loans
    resources :statuses
    resources :moneylenders
    resources :loan_types
  end

  resources :creditors, only: [:index, :show]
  resources :loans
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "dashboard#home"
end
