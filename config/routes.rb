# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  devise_for :users
  # ROOT
  root to: 'home#index'


  # HOME controller routing
  get 'home/index'
  get 'home/contact'
  get 'home/sign_up'
  get 'home/log_in'
  get 'home/show_fundraisers'
  get 'home/show_groups'
  get 'home/show_goals'
  get 'home/myAccount'
  get 'home/manage'
  get 'about', to: 'home#about', foo: 'about'
  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'

  # Resources
  resources :goals
  resources :groups
  resources :users, only: [:show, :index]
  delete "users/:id", to: "users#destroy"
  # goal controller routing
  get 'goals/index', to: 'goals#index', foo: 'groupGoal'


  # Additional routes
  get '/groups/:id/add_member', to: 'groups#show_add_member', as: 'show_add_member'
  post '/groups/:id/add_member', to: 'groups#add_group_member', as: 'add_member'

  # Payment processing. Only need to access PayPal Make Order endpoint and viewing the order
  # from our own database records.
  post 'payment_processing/make_payment', to: 'payment_processing#make_payment', as: 'make_payment'
  get 'payment_processing/view_payment'

end
