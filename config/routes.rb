Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  namespace :admin do
    get 'index', as: "index"
    get 'export_payments', as: "export_payments"
    get 'export_loans', as: "export_loans"
    resources :extra_fees
    resources :payments
    resources :loans
    resources :statuses
    resources :moneylenders
    resources :loan_types
    resources :users
  end

  
  get "creditors/new_loan/:money_lender_id" => "creditors#new_loan"
  get "creditors/list_all" => "creditors#list_all"
  get "creditors/:moneylender_id/only_buttons" => "creditors#only_buttons"
  get "creditors/:moneylender_id/user_loans/:user_id" => "creditors#user_loans"
  get "creditors/:moneylender_id/weekly_payments/:year/:week" => "creditors#weekly_payments"
  resources :creditors, only: [:index, :show]
  resources :loans do
    resources :payments
    get "payments/new/:parent_id" => "payments#new", as: "new_subpayment"
  end

  namespace :client do
    get 'search'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "dashboard#home"
end
