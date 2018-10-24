Rails.application.routes.draw do
  resources :illness_diagnoses
  resources :functionaries
  resources :appointments
  resources :patients
  resources :users
  resources :treatment_pacients
  resources :levels
  resources :patient_diagnoses
  resources :statuses
  resources :treatment_types
  resources :treatments
  resources :functionary_types
  resources :areas
  resources :center_types
  resources :attention_centers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
