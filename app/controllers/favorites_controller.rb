class FavoritesController < ApplicationController

  def Index
    @user = User.find(params[:id])
  end

  def tasks_show
    @favorites = Favorite.where(user_id: current_user.id, service_name: "タスク").paginate(page: params[:page])
    @tasks = Task.where(id: @favorites.pluck(:service_id))
  end

  def quizzes_show
    @favorites = Favorite.where(user_id: current_user.id, service_name: "クイズ").paginate(page: params[:page]) 
    @quizzes = Quiz.where(id: @favorites.pluck(:service_id))
  end

  def novels_show
    @favorites = Favorite.where(user_id: current_user.id, service_name: "小説感想").paginate(page: params[:page]) 
    @novels = Novel.where(id: @favorites.pluck(:service_id))
  end

  def mini_know_hows_show
    @favorites = Favorite.where(user_id: current_user.id, service_name: "ミニノウハウ").paginate(page: params[:page]) 
    @mini_know_hows = MiniKnowHow.where(id: @favorites.pluck(:service_id))
  end

  def praise_mes_show
    @favorites = Favorite.where(user_id: current_user.id, service_name: "ほめて！").paginate(page: params[:page]) 
    @praise_mes = PraiseMe.where(id: @favorites.pluck(:service_id))
  end

  def hyakuhyakus_show
    @favorites = Favorite.where(user_id: current_user.id, service_name: "百百").paginate(page: params[:page]) 
    @hyakuhyakus = Hyakuhyaku.where(id: @favorites.pluck(:service_id))
  end

  def five_percentage_reviews_show
    @favorites = Favorite.where(user_id: current_user.id, service_name: "５％レビュー").paginate(page: params[:page]) 
    @five_percentage_reviews = FivePercentageReview.where(id: @favorites.pluck(:service_id))
  end

  def one_yen_articles_show
    @favorites = Favorite.where(user_id: current_user.id, service_name: "１円記事").paginate(page: params[:page]) 
    @one_yen_articles = OneYenArticle.where(id: @favorites.pluck(:service_id))
  end
end
