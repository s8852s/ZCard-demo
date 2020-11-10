Rails.application.routes.draw do
  root "boards#index"
  resources :boards

  # get "/", to :"boards#index"
  #root "boards#index"
end
