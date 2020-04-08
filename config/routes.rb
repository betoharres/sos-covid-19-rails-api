Rails.application.routes.draw do
  post 'patient_state/call/:id', to: 'patient_state#call'
  post 'patient_state/visit/:id', to: 'patient_state#visit'
  post 'patient_state/discard/:id', to: 'patient_state#discard'
  post 'patient_state/infect/:id', to: 'patient_state#infect'
  post 'patient_state/history/:id', to: 'patient_state#history'

  resources :patients
  resources :volunteers
  # resources :phones

  post '/phones/validate', to: 'phones#validate'
end
