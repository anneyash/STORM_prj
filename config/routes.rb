Rails.application.routes.draw do

  get 'tasks/new'
  get 'tasks/create'
  get 'tasks/destroy'
  get 'tasks/today'
  get 'projects/new'
  get 'projects/create'
  get 'projects/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :sessions, only: [:new, :create, :destroy]


    get 'static_pages/index'
    get 'signin' => 'sessions#new'
    get 'signup' => 'users#new'

    get '/task/:id/todo', to: 'tasks#make_todo'
      get '/task/:id/today', to: 'tasks#make_today'
        get '/task/:id/in_process', to: 'tasks#make_in_process'
          get '/task/:id/done', to: 'tasks#make_done'


  get '/tasks/notifications', to: 'tasks#notifications'

  post '/tasks/makealltodo', to: 'tasks#makealltodo'
  post '/tasks/makealltoday', to: 'tasks#makealltoday'

    delete '/signout', to: 'sessions#destroy'

    root 'static_pages#index'

    resources :projects, only: [:create, :destroy, :index, :update, :show]
    resources :points, only: [:index]
    resources :users, only: [:show, :create]
    resources :tasks, only: [:create, :destroy, :index, :show, :edit, :update] do
      get :today
    end

end
