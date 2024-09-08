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
  get "quizzes/:quizzes_id/see_answer", to: "quizzes#see_answer", as: 'quizzes_see_answer'
  get "quizzes/index_all"
  get "novels/new"
  get "novels/:novel_id", to: "novels#show", as:'novels_show'
  get "thoughts/new", to: "thoughts#new", as: 'thoughts_new'
  get "thoughts/:thought_id", to: "thoughts#show", as: 'thoughts_show'
  get "novels/:novel_id/thoughts/:thought_id/update", to: "thoughts#update", as: 'thoughts_update'
  get "users/:id/point_logs", to: "users#point_logs", as: 'users_point_logs'
  
  resources :novels,              only: [:new, :create, :show, :index, :update] do
    resources :thoughts, param: :thought_id,only: [:create, :new, :show, :index, :update, :edit]
  end
  resources :quizzes, param: :quizzes_id, only: [:new, :create, :edit, :show, :index, :update]
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :tasks,               only: [:create, :edit, :show, :update, :destroy ,:index, :new] do
    resources :supports,            only: [:new, :create, :show, :index]
  end


end