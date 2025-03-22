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
  get "users/:id/show_probably_a_hit", to: "users#show_probably_a_hit", as: "users_show_probably_a_hit"
  get "tasks/index"
  get "tasks/index2"
  get "tasks/:id/last_message", to: "tasks#last_message",  as: 'tasks_last_message'
  patch "tasks/:id/last_message", to: "tasks#update_last_message"
  patch 'tasks/:id/status_run/', to: "tasks#status_run", as: 'task_status_run'
  get "tasks/:id/favorites_add/", to: "tasks#favorites_add", as: 'tasks_favorites_add'
  get "tasks/search/", to: "tasks#search", as: 'tasks_search'
  get "tasks/search_result/", to: "tasks#search_result", as: 'tasks_search_result'
  delete "tasks/:id/favorites_delete/", to: "tasks#favorites_delete", as: 'tasks_favorites_delete'
  get "supports/new"
  get "supports/tasks/:id", to: "supports#index", as: 'supports_index'
  patch 'tasks/candidate/:id', to: "tasks#candidate", as: 'tasks_candidate'
  get "quizzes/:id/favorites_add/", to: "quizzes#favorites_add", as: 'quizzes_favorites_add'
  delete "quizzes/:id/favorites_delete/", to: "quizzes#favorites_delete", as: 'quizzes_favorites_delete'
  get "quizzes/:quizzes_id/answer", to: "quizzes#answer", as: 'quizzes_answer'
  patch "quizzes/:quizzes_id/create_answer", to: "quizzes#create_answer"
  get "quizzes/:quizzes_id/answer_result", to: "quizzes#answer_result", as: 'quizzes_answer_result'
  get "quizzes/:quizzes_id/see_answer", to: "quizzes#see_answer", as: 'quizzes_see_answer'
  get "quizzes/search/", to: "quizzes#search", as: 'quizzes_search'
  get "quizzes/search_result/", to: "quizzes#search_result", as: 'quizzes_search_result'
  get "quizzes/index_all"
  get "novels/new"
  get "novels/search_result/", to: "novels#search_result", as: 'novels_search_result'
  get "novels/search/", to: "novels#search", as: 'novels_search'
  get "novels/index2", to: "novels#index2", as: 'novels_index2'
  get "novels/:novel_id/show2", to:"novels#show2", as: 'novels_show2'
  get "novels/:novel_id", to: "novels#show", as:'novels_show'
  get "novels/:id/status", to: "novels#status", as:'novels_status'
  patch "novels/:id/status", to: "novels#update_status"
  get "novels/:id/favorites_add/", to: "novels#favorites_add", as: 'novels_favorites_add'
  delete "novels/:id/favorites_delete/", to: "novels#favorites_delete", as: 'novels_favorites_delete'
  get "thoughts/new", to: "thoughts#new", as: 'thoughts_new'
  get "thoughts/:thought_id", to: "thoughts#show", as: 'thoughts_show'
  get "novels/:novel_id/thoughts/:thought_id/update", to: "thoughts#update", as: 'thoughts_update'
  get "novels/:novel_id/novel_probably_a_hit", to: "novels#novel_probably_a_hit", as: "novels_novel_probably_a_hit"
  get "favorites/:user_id/tasks_show", to:"favorites#tasks_show", as: 'favorites_tasks_show'
  get "favorites/:user_id/quizzes_show", to:"favorites#quizzes_show", as: 'favorites_quizzes_show'
  get "favorites/:user_id/novels_show", to:"favorites#novels_show", as: 'favorites_novels_show'
  get "favorites/:user_id/mini_know_hows_show", to:"favorites#mini_know_hows_show", as: 'favorites_mini_know_hows_show'
  get "favorites/:user_id/praise_mes_show", to:"favorites#praise_mes_show", as: 'favorites_praise_mes_show'
  get "favorites/:user_id/hyakuhyakus_show", to:"favorites#hyakuhyakus_show", as: 'favorites_hyakuhyakus_show'
  get "favorites/:user_id/five_percentage_reviews_show", to:"favorites#five_percentage_reviews_show", as: 'favorites_five_percentage_reviews_show'
  get "point_mails/index2"
  get "mini_know_hows/:id/favorites_add/", to: "mini_know_hows#favorites_add", as: 'mini_know_hows_favorites_add'
  delete "mini_know_hows/:id/favorites_delete/", to: "mini_know_hows#favorites_delete", as: 'mini_know_hows_favorites_delete'
  delete "mini_know_hows/:id/refund", to:"mini_know_hows#refund", as: 'mini_know_hows_refund'
  get "mini_know_hows/search_result/", to: "mini_know_hows#search_result", as: 'mini_know_hows_search_result'
  get "mini_know_hows/search/", to: "mini_know_hows#search", as: 'mini_know_hows_search'
  get "praise_mes/:praise_me_id/praise/:praise_id/comment_adopt", to:"praise#comment_adopt", as: 'praise_comment_adopt'
  get "praise_mes/:praise_me_id/rest0", to:"praise_mes#rest0", as: 'praise_mes_rest0'
  get "praise_mes/search/", to: "praise_mes#search", as: 'praise_mes_search'
  get "praise_mes/search_result/", to: "praise_mes#search_result", as: 'praise_mes_search_result'
  get "praise_mes/:id/favorites_add/", to: "praise_mes#favorites_add", as: 'praise_mes_favorites_add'
  delete "praise_mes/:id/favorites_delete/", to: "praise_mes#favorites_delete", as: 'praise_mes_favorites_delete'
  get "hyakuhyakus/:id/favorites_add/", to: "hyakuhyakus#favorites_add", as: 'hyakuhyakus_favorites_add'
  delete "hyakuhyakus/:id/favorites_delete/", to: "hyakuhyakus#favorites_delete", as: 'hyakuhyakus_favorites_delete'
  delete "hyakuhyakus/:id/refund", to:"hyakuhyakus#refund", as: 'hyakuhyakus_refund'
  get "hyakuhyakus/search_result/", to: "hyakuhyakus#search_result", as: 'hyakuhyakus_search_result'
  get "hyakuhyakus/search/", to: "hyakuhyakus#search", as: 'hyakuhyakus_search'
  get "five_percentage_reviews/search_result/", to: "five_percentage_reviews#search_result", as: 'five_percentage_reviews_search_result'
  get "five_percentage_reviews/search/", to: "five_percentage_reviews#search", as: 'five_percentage_reviews_search'
  get "five_percentage_reviews/:id/favorites_add/", to: "five_percentage_reviews#favorites_add", as: 'five_percentage_reviews_favorites_add'
  delete "five_percentage_reviews/:id/favorites_delete/", to: "five_percentage_reviews#favorites_delete", as: 'five_percentage_reviews_favorites_delete'
  get "five_percentage_reviews/index2", to: "five_percentage_reviews#index2", as: 'five_percentage_reviews_index2'

  resources :five_percentage_reviews, param: :five_percentage_review_id,  only: [:new, :create, :edit, :update,:show, :index]
  resources :novels,              only: [:new, :create, :show, :edit, :update, :index, :update] do
    resources :thoughts, param: :thought_id,only: [:create, :new, :show, :index, :update, :edit]
    resources :novels_supports,            only: [:new, :create, :show, :index]
  end
  resources :quizzes, param: :quizzes_id, only: [:new, :create, :edit, :show, :index, :update]
  resources :point_logs,          only: [:new, :create, :show]
  resources :point_mails,         only: [:new, :create, :index, :show]
  resources :favorites,           only: [:index]
  resources :mini_know_hows,      only: [:new, :create, :index, :show]
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :tasks,               only: [:create, :edit, :show, :update, :destroy ,:index, :new] do
    resources :supports,          only: [:new, :create, :show, :index]
  end
  resources :praise_mes,          only:[:new, :create, :show, :index, :destroy] do
    resources :praise,            only:[:new, :create, :show, :index]
  end
  resources :hyakuhyakus,          only: [:new, :create, :index, :show]
  resources :feedback_and_inquiries, param: :feedback_and_inquiries_id, only: [:new,:create,:index, :show] do
    resources :responses_to_comments_and_inquiries, only: [:new,:create,:index,:show] 
  end
end