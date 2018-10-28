Rails.application.routes.draw do
  
  root "logins#index"

  resources :logins
  resources :diagnoses
  resources :appointments
  resources :treatments
  resources :users
  resources :patients
  resources :functionaries
  resources :attention_centers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
