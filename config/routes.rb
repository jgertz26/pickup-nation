Rails.application.routes.draw do
  root 'courts#index'

  devise_for :users

  resources :courts
end
