Rails.application.routes.draw do
  namespace :api do

    namespace :student do 
      resources :activity_logs, only: [:index]
      resources :projects, only: [:index, :create, :show, :update]
      resources :project_reservations, only: [:create]
      resources :teachers, only: [:index]
      resources :subjects, only: [:index]
      resources :session, only: [:create, :destroy]
      resource :students, only: [:show]

      namespace :teacher do
        resources :subjects, only: [:index]
      end

      namespace :project do
        resources :team_members, only: [:create]
        resources :chats, only: [:create, :index]
        resources :to_dos, only: [:create, :index] do
          post :done
        end
      end
    end 

    namespace :teacher do
      resources :activity_logs, only: [:index]
      resources :session, only: [:create, :destroy]
      resources :subjects, only: [:index]
      resources :projects, only: [:index, :create, :show, :update] do
        post :accept  
      end
      
      namespace :project do
        resources :divisions, only: [:create]
        resources :chats, only: [:create, :index]
        resources :comments, only: [:create]
      end
    end

    resources :students, only: [:index]
    resources :categories, only: [:index]
    resources :technologies, only: [:index]
    resources :diploma_projects, only: [:index]
    resources :subject_projects, only: [:index]
  end
  
  namespace :admin do
    resources :logs, only: [:index]
  end

  get "/*all", to: 'static_pages#index', constraints: { :all => /.*/ }
  root 'static_pages#index'

end
