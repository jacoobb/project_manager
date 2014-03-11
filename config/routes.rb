Rails.application.routes.draw do
  namespace :api do

    namespace :student do 
      resources :teachers, only: [:index]
      resources :session, only: [:create, :destroy]
      resource :students, only: [:show]
    end 
  end
  
  namespace :admin do
    resources :logs, only: [:index]
  end
  root 'static_pages#index'

end
