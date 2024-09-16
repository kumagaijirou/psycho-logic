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

end
