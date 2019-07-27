Rails.application.routes.draw do
  root 'users#index'
  resources :pets
  resources :reviews
  
  get 'users/index'
  get 'users/sign_out'
  devise_for :users
  
  get 'like_hospitals/list'
  
  get 'hospitals/view'
  get 'hospitals/list'
  get 'diseases/list'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
