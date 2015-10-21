Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users

  resources :courts do
    resources :meetups, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :meetups, only: :index do
    resources :attendees, only: :create
  end
end
