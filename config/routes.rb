Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  get 'tasks/new'
  root "static_pages#home"
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
  get  "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  get "users/ranking", to: "users#ranking"
  get "tasks/index"
  get "tasks/index2"
  get "tasks/:id/last_message", to: "tasks#last_message",  as: 'tasks_last_message'
  patch "tasks/:id/last_message", to: "tasks#update_last_message"
  patch 'tasks/:id/status_run/', to: "tasks#status_run", as: 'task_status_run'
  get "supports/new"
  get "supports/tasks/:id", to: "supports#index", as: 'supports_index'
  patch 'tasks/candidate/:id', to: "tasks#candidate", as: 'tasks_candidate'
  get "quizzes/:quizzes_id/answer", to: "quizzes#answer", as: 'quizzes_answer'
  patch "quizzes/:quizzes_id/create_answer", to: "quizzes#create_answer"
  get "quizzes/:quizzes_id/answer_result", to: "quizzes#answer_result", as: 'quizzes_answer_result'
  get "quizzes/new", to: "quizzes#new", as: 'quizzes_new'
  get "quizzes/:quizzes_id/see_answer", to: "quizzes#see_answer", as: 'quizzes_see_answer'
  get "quizzes/index_all"
  get "quizzes/:id", to: "quizzes#show"
  get "quizzes/index"
  get "quizzes/:quizzes_id/edit", to: "quizzes#edit", as: 'quizzes_edit'
  get "quizzes/:quizzes_id/update", to: "quizzes#update", as: 'quizzes_update'
  get "novels/new"
  get "novels/:novels_id", to: "novels#show", as:'novels_show'
  get "thoughts/new", to: "thoughts#new", as: 'thoughts_new'
  
  
  resources :novels,              only: [:new, :create, :show, :index, :update] 
  resources :thoughts,          only: [:new, :create, :show, :index]
  resources :quizzes,             only: [:new, :create, :edit, :show, :index, :update]
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :tasks,               only: [:create, :edit, :show, :update, :destroy ,:index, :new] do
    resources :supports,            only: [:new, :create, :show, :index]
  end


end