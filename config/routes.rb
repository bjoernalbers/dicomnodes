Rails.application.routes.draw do
  resources :imports, only: [:index, :new, :create]
  root 'imports#index'
end
