Rails.application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  post '/webhooks/stripe', to: 'webhooks#stripe'
  post 'checkout', to: 'payments#checkout'
  get '/success', to: 'payments#success'
  get '/cancel', to: 'payments#cancel'
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
  get "tasks/:id/okiniiris_add/", to: "tasks#okiniiris_add", as: 'tasks_okiniiris_add'
  get "tasks/search/", to: "tasks#search", as: 'tasks_search'
  get "tasks/search_result/", to: "tasks#search_result", as: 'tasks_search_result'
  delete "tasks/:id/okiniiris_delete/", to: "tasks#okiniiris_delete", as: 'tasks_okiniiris_delete'
  get "supports/new"
  get "supports/tasks/:id", to: "supports#index", as: 'supports_index'
  patch 'tasks/candidate/:id', to: "tasks#candidate", as: 'tasks_candidate'
  get "quizzes/:id/okiniiris_add/", to: "quizzes#okiniiris_add", as: 'quizzes_okiniiris_add'
  delete "quizzes/:id/okiniiris_delete/", to: "quizzes#okiniiris_delete", as: 'quizzes_okiniiris_delete'
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
  get "novels/:id/okiniiris_add/", to: "novels#okiniiris_add", as: 'novels_okiniiris_add'
  delete "novels/:id/okiniiris_delete/", to: "novels#okiniiris_delete", as: 'novels_okiniiris_delete'
  get "thoughts/new", to: "thoughts#new", as: 'thoughts_new'
  get "thoughts/:thought_id", to: "thoughts#show", as: 'thoughts_show'
  get "novels/:novel_id/thoughts/:thought_id/update", to: "thoughts#update", as: 'thoughts_update'
  get "novels/:novel_id/novel_probably_a_hit", to: "novels#novel_probably_a_hit", as: "novels_novel_probably_a_hit"
  get "okiniiris/:user_id/tasks_show", to:"okiniiris#tasks_show", as: 'okiniiris_tasks_show'
  get "okiniiris/:user_id/quizzes_show", to:"okiniiris#quizzes_show", as: 'okiniiris_quizzes_show'
  get "okiniiris/:user_id/novels_show", to:"okiniiris#novels_show", as: 'okiniiris_novels_show'
  get "okiniiris/:user_id/mini_know_hows_show", to:"okiniiris#mini_know_hows_show", as: 'okiniiris_mini_know_hows_show'
  get "okiniiris/:user_id/praise_mes_show", to:"okiniiris#praise_mes_show", as: 'okiniiris_praise_mes_show'
  get "okiniiris/:user_id/hyakuhyakus_show", to:"okiniiris#hyakuhyakus_show", as: 'okiniiris_hyakuhyakus_show'
  get "okiniiris/:user_id/five_percentage_reviews_show", to:"okiniiris#five_percentage_reviews_show", as: 'okiniiris_five_percentage_reviews_show'
  get "okiniiris/:user_id/one_yen_articles_show", to:"okiniiris#one_yen_articles_show", as: 'okiniiris_one_yen_articles_show'
  get "okiniiris/:user_id/novel_services_show", to:"okiniiris#novel_services_show", as: 'okiniiris_novel_services_show'
  get "point_mails/index2"
  get "mini_know_hows/:id/okiniiris_add/", to: "mini_know_hows#okiniiris_add", as: 'mini_know_hows_okiniiris_add'
  delete "mini_know_hows/:id/okiniiris_delete/", to: "mini_know_hows#okiniiris_delete", as: 'mini_know_hows_okiniiris_delete'
  delete "mini_know_hows/:id/refund", to:"mini_know_hows#refund", as: 'mini_know_hows_refund'
  get "mini_know_hows/search_result/", to: "mini_know_hows#search_result", as: 'mini_know_hows_search_result'
  get "mini_know_hows/search/", to: "mini_know_hows#search", as: 'mini_know_hows_search'
  get "praise_mes/:praise_me_id/praise/:praise_id/comment_adopt", to:"praise#comment_adopt", as: 'praise_comment_adopt'
  get "praise_mes/:praise_me_id/rest0", to:"praise_mes#rest0", as: 'praise_mes_rest0'
  get "praise_mes/search/", to: "praise_mes#search", as: 'praise_mes_search'
  get "praise_mes/search_result/", to: "praise_mes#search_result", as: 'praise_mes_search_result'
  get "praise_mes/:id/okiniiris_add/", to: "praise_mes#okiniiris_add", as: 'praise_mes_okiniiris_add'
  delete "praise_mes/:id/okiniiris_delete/", to: "praise_mes#okiniiris_delete", as: 'praise_mes_okiniiris_delete'
  get "hyakuhyakus/:id/okiniiris_add/", to: "hyakuhyakus#okiniiris_add", as: 'hyakuhyakus_okiniiris_add'
  delete "hyakuhyakus/:id/okiniiris_delete/", to: "hyakuhyakus#okiniiris_delete", as: 'hyakuhyakus_okiniiris_delete'
  delete "hyakuhyakus/:id/refund", to:"hyakuhyakus#refund", as: 'hyakuhyakus_refund'
  get "hyakuhyakus/search_result/", to: "hyakuhyakus#search_result", as: 'hyakuhyakus_search_result'
  get "hyakuhyakus/search/", to: "hyakuhyakus#search", as: 'hyakuhyakus_search'
  get "five_percentage_reviews/search_result/", to: "five_percentage_reviews#search_result", as: 'five_percentage_reviews_search_result'
  get "five_percentage_reviews/search/", to: "five_percentage_reviews#search", as: 'five_percentage_reviews_search'
  get "five_percentage_reviews/:five_percentage_review_id/okiniiris_add/", to: "five_percentage_reviews#okiniiris_add", as: 'five_percentage_reviews_okiniiris_add'
  delete "five_percentage_reviews/:five_percentage_review_id/okiniiris_delete/", to: "five_percentage_reviews#okiniiris_delete", as: 'five_percentage_reviews_okiniiris_delete'
  get "five_percentage_reviews/index2", to: "five_percentage_reviews#index2", as: 'five_percentage_reviews_index2'
  get "one_yen_articles/:id/prompt_show", to: "one_yen_articles#prompt_show", as: 'one_yen_articles_prompt_show'
  get "one_yen_articles/search_result/", to: "one_yen_articles#search_result", as: 'one_yen_articles_search_result'
  get "one_yen_articles/search/", to: "one_yen_articles#search", as: 'one_yen_articles_search'
  get "one_yen_articles/:id/okiniiris_add/", to: "one_yen_articles#okiniiris_add", as: 'one_yen_articles_okiniiris_add'
  delete "one_yen_articles/:id/okiniiris_delete/", to: "one_yen_articles#okiniiris_delete", as: 'one_yen_articles_okiniiris_delete'
  get "novel_services/:id/okiniiris_add/", to: "novel_services#okiniiris_add", as: 'novel_services_okiniiris_add'
  delete "novel_services/:id/okiniiris_delete/", to: "novel_services#okiniiris_delete", as: 'novel_services_okiniiris_delete'
  get "novel_services/search_result/", to: "novel_services#search_result", as: 'novel_services_search_result'
  get "novel_services/search/", to: "novel_services#search", as: 'novel_services_search'
  

  resources :five_percentage_reviews, param: :five_percentage_review_id,  only: [:new, :create, :edit, :update,:show, :index]
  resources :novels,              only: [:new, :create, :show, :edit, :update, :index, :update] do
    resources :thoughts, param: :thought_id,only: [:create, :new, :show, :index, :update, :edit]
    resources :novels_supports,            only: [:new, :create, :show, :index]
  end
  resources :quizzes, param: :quizzes_id, only: [:new, :create, :edit, :show, :index, :update]
  resources :point_logs,          only: [:new, :create, :show]
  resources :point_mails,         only: [:new, :create, :index, :show]
  resources :okiniiris,           only: [:index]
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
  resources :one_yen_articles,     only: [:new, :create, :destroy,:show, :index, :edit, :update]
  resources :novel_services,     only: [:new, :create, :destroy,:show, :index, :edit]
end