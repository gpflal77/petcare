Rails.application.routes.draw do
  root 'users#index'
  resources :pets
  resources :reviews
 # patch 'reviews/:id' => 'reviews#update'

 # put 'reviews/:id' => 'reviews#update'
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
  
  get 'hospitals/get_nearby_hospital_reviews' => 'hospitals#get_nearby_hospital_reviews',  defaults: { format: 'json' }
  
  get 'hospitals/get_nearby_hospital_satis' => 'hospitals#get_nearby_hospital_satis',  defaults: { format: 'json' }

  get 'diseases/get_search_cost' => 'diseases#get_search_cost',  defaults: { format: 'json' }
  get 'diseases/get_medic_reviews' => 'diseases#get_medic_reviews',  defaults: { format: 'json' }


  post 'pets/update/:id' => 'pets#update'
  post 'reviews/update/:id' => 'reviews#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
