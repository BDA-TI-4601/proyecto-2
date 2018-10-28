Rails.application.routes.draw do
  
  resources :users
  resources :appointments
  resources :patients
  resources :treatments
  resources :diagnoses
  resources :functionaries
  resources :attention_centers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
