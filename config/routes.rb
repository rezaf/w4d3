Rails.application.routes.draw do
  resources :cats do 
    resources :cat_rental_requests, only: :index
  end
  
  resources :cat_rental_requests, only: [:new, :create, :update, :destroy]
  
  resource :user, only: [:new, :create, :show]
  resource :session, only: [:create, :new, :destroy]
  
end
