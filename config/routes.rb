Rails.application.routes.draw do
  devise_for :users 
 root to: "home#home"

 scope '/dashboard' do
  get "/" => 'dashboard#show', as: 'dashboard'
  get '/bikes' => 'bikes#index', as: 'bikes'
  get '/bikes/close' => 'bikes#close', as: 'close_bikes'
  get '/buses' => 'buses#index', as: 'buses'
  get '/rails' => 'rails#index', as: 'rails'
  resources :station, only: [:create, :new, :destroy] 
 end


end
