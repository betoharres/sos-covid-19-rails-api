Rails.application.routes.draw do
  post 'patient_state/call/:patient_id', to: 'patient_state#call'
  post 'patient_state/visit/:patient_id', to: 'patient_state#visit'
  post 'patient_state/discard/:patient_id', to: 'patient_state#discard'
  post 'patient_state/infect/:patient_id', to: 'patient_state#infect'
  post 'patient_state/history/:patient_id', to: 'patient_state#history'

  resources :patients
  resources :volunteers, except: :index
  # resources :phones

  post '/phones/validate', to: 'phones#validate'
end
