Rails.application.routes.draw do
  require 'sidekiq/web'
  get 'sidekiq_api', to: 'sidekiq_api#index'

  resources :patients
  resources :volunteers, except: :index
  resources :phones, only: :create

  post 'patient_state/call/:patient_id', to: 'patient_state#call'
  post 'patient_state/visit/:patient_id', to: 'patient_state#visit'
  post 'patient_state/discard/:patient_id', to: 'patient_state#discard'
  post 'patient_state/infect/:patient_id', to: 'patient_state#infect'

  get 'patient_state/history/:patient_id', to: 'patient_state#history'

  post '/phones/validate', to: 'phones#validate'
  post '/phones/resend_sms_code', to: 'phones#resend_sms_code'
  post '/login', to: 'session#new'

  get '/guest', to: 'patients#guest'
end
