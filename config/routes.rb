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

  # Resources
  resources :goals
  resources :groups

  # Additional routes
  get '/groups/:id/add_member', to: 'groups#show_add_member', as: 'show_add_member'
  post '/groups/:id/add_member', to: 'groups#add_group_member', as: 'add_member'

  # Payment processing. Only need to access PayPal Make Order endpoint and viewing the order
  # from our own database records.
  post 'payment_processing/make_payment', to: 'payment_processing#make_payment', as: 'make_payment'
  get 'payment_processing/view_payment'

end
