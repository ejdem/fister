Rails.application.routes.draw do
  resources :communes, only: [:index, :create, :update, :show], defaults: { format: :json }
end
