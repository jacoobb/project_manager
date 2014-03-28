Rails.application.routes.draw do
  namespace :api do

    namespace :student do 
      resources :projects, only: [:index, :create]
      resources :teachers, only: [:index]
      resources :subjects, only: [:index]
      resources :session, only: [:create, :destroy]
      resource :students, only: [:show]

      namespace :teacher do
        resources :subjects, only: [:index]
      end
    end 

    namespace :teacher do
      resources :session, only: [:create, :destroy]
      resources :subjects, only: [:index]
      resources :projects, only: [:index, :create]
    end

    resources :categories, only: [:index]
    resources :technologies, only: [:index]
    resources :diploma_projects, only: [:index]
  end
  
  namespace :admin do
    resources :logs, only: [:index]
  end
  root 'static_pages#index'

end
