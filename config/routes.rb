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

  
  get "creditors/new_loan/:money_lender_id" => "creditors#new_loan"
  get "creditors/list_all" => "creditors#list_all"
  get "creditors/:moneylender_id/user_loans/:user_id" => "creditors#user_loans"
  resources :creditors, only: [:index, :show]
  resources :loans do
    resources :payments
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "dashboard#home"
end
