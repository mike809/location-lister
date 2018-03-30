Rails.application.routes.draw do
  post '/', to: 'locations#create', as: :locations
  root to: 'locations#index'
end
