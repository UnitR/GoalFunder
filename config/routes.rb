# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  get 'admin_reports/index'
  get 'admin_reports/show'
  devise_for :users
  # ROOT
  root to: 'home#index'


  # HOME controller routing
  get 'home/index'
  get 'home/contact', foo: 'contact'
  get 'home/sign_up'
  get 'home/log_in'
  get 'home/show_fundraisers'
  get 'home/show_groups'
  get 'home/show_goals'
  get 'home/myAccount', foo: 'account'
  get 'home/manage', foo: 'manage'
  get 'about', to: 'home#about', foo: 'about'
  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'

  # Resources
  resources :goals
  #resources :groups
  resources :users, only: [:show, :index]
  resources :invites



  # goal controller routing
  get 'goals/index', to: 'goals#index', foo: 'groupGoal'
  get '/persGoals', to: 'goals#persGoals', foo: 'persGoal'


  # Group controller routing
  get '/groups/:id/add_member', to: 'groups#show_add_member', as: 'show_add_member'
  get '/groups/new', to: 'groups#new', as: 'new_group'
  get '/groups', to: 'groups#index', as: 'groups'
  post '/groups/:id/add_member', to: 'groups#add_group_member', as: 'add_member'
  post '/groups/new', to: 'groups#create'
  post '/groups', to: 'groups#index'

  # Payment processing. Only need to access PayPal Make Order endpoint and viewing the order
  # from our own database records.
  post 'payment_processing/make_payment', to: 'payment_processing#make_payment', as: 'make_payment'
  get 'payments/all', to: 'payment_processing#view_all', as: 'view_payment_history'

  # PDF Reports
  get '/admin_reports/:report_type', to: 'admin_reports#index', as: 'report_gen_path'

  # ActionCable for dynamic payment showing
  mount ActionCable.server => '/payments'

end
