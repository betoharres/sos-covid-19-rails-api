Rails.application.routes.draw do
  resources :patients
  resources :volunteers
  # resources :phones

  post '/phones/validate', to: 'phones#validate'
end
