# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

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

end
