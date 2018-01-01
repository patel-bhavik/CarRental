Rails.application.routes.draw do
  resources :suggested_cars
  root 'cars#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :users
  resources :cars do
    resources :reservations
  end
  resources :suggested_cars
  get 'reservation_history', to: 'users#reservation_history'
  get 'cars/:id/subscriptions/new_subscription', to: 'subscriptions#new_sbscription', as: 'new_subscription'
  namespace :admin do
    root 'admin/cars#index'
    resources :users do
      resources :reservations, only: [:new, :create]
    end
    get 'customers', to: 'users#customers'
    resources :cars
    get 'cars/:id/edit_status', to: 'cars#edit_status', as: 'car_edit_status'
    get 'suggested_cars/:id/cars/new_suggested_car', to: 'cars#new_suggested_car', as: 'new_suggested_car'
    post 'suggested_cars/:id/cars/create_suggested_car', to: 'cars#create_suggested_car', as: 'create_suggested_car'
    patch 'cars/:id/update_status', to: 'cars#update_status', as: 'car_update_status'
    get 'cars/:id/reservation_history', to: 'cars#reservation_history', as: 'car_reservation_history'
    get 'users/:id/reservation_history', to: 'users#reservation_history', as: 'user_reservation_history'
    resources :reservations
  end
  namespace :super_admin do
    root 'admin/cars#index'
    resources :users
  end
end
