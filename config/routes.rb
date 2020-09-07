Rails.application.routes.draw do
  resources :rooms, only: [:new, :create, :destroy, :show]
  resource :token, only: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
