Rails.application.routes.draw do
  
  get 'appointment_patients/index2'
  get 'appointment_patients/index3'
  get 'appointment_patients/index4'
  get 'appointment_patients/delete_app'
  get 'doctors/index2'
  get 'doctors/index3'
  get 'doctors/index4'
  get 'doctors/showall'
  get 'doctors/index5'
  get 'doctors/index6'
  get 'secretaries/index2'
  get 'secretaries/index3'
  get 'secretaries/index4'
  get 'secretaries/index5'
  get 'secretaries/delete_app'
  get 'secretaries/assign_app'
  get 'secretaries/by_patient'
  get 'administrators/refresh'
  get 'administrators/operations'

  root "logins#index"

  resources :administrators
  resources :doctors
  resources :secretaries
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
