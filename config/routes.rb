Rails.application.routes.draw do
  root 'users#index'
  resources :pets
  resources :reviews
  
  get 'users/index'
  get 'users/sign_out'
  devise_for :users
  
  get 'like_hospitals/list'
  
  #get 'hospitals/view'
  get 'hospitals/view/:hospital_id' => 'hospitals#view',  as: 'hospitals_view'
  get 'hospitals/view/:hospital_id/like' => 'hospitals#like'
  
 # get 'hospitals/list'
  
  get 'hospitals/list'
  get 'diseases/list'

  get 'hospitals/get_code' => 'hospitals#get_code',  defaults: { format: 'js' }
  get 'get_code' => 'application#get_code',  defaults: { format: 'json' }
  
  get 'hospitals/get_nearby_hospital' => 'hospitals#get_nearby_hospital',  defaults: { format: 'json' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
