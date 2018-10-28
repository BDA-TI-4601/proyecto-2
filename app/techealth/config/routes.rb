Rails.application.routes.draw do
  
  resources :diagnoses
  resources :appointments
  resources :treatments
  resources :users
  resources :patients
  resources :functionaries
  resources :attention_centers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
