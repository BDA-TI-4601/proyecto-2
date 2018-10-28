Rails.application.routes.draw do
  
  get 'appointment_patients/index2'
  get 'appointment_patients/index3'
  get 'appointment_patients/index4'
  get 'doctors/index2'
  get 'doctors/index3'
  get 'doctors/index4'
  get 'doctors/delete_app'
  root "logins#index"

  resources :doctors
  resources :appointment_patients
  resources :appointments
  resources :logins
  resources :diagnoses
  resources :treatments
  resources :users
  resources :patients
  resources :functionaries
  resources :attention_centers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
