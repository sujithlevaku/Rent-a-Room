Rails.application.routes.draw do
  resources :amenities
  get "rooms/unauthorized_rooms"
  get "rooms/my_rooms"
  resources :rooms
  devise_for :users
  resources :cities
  resources :roles
  get "bookings/unconfirmed_bookings"
  resources :bookings
  root to: 'rooms#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
