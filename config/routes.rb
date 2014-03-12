Rails.application.routes.draw do
  namespace :api do

    namespace :student do 
      resources :teachers, only: [:index]
      resources :subjects, only: [:index]
      resources :session, only: [:create, :destroy]
      resource :students, only: [:show]

      namespace :teacher do
        resources :subjects, only: [:index]
      end
    end 
  end
  
  namespace :admin do
    resources :logs, only: [:index]
  end
  root 'static_pages#index'

end
