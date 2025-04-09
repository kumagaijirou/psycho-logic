class OkiniirisController < ApplicationController

  def Index
    @user = User.find(params[:id])
  end

  def tasks_show
    @okiniiris = Okiniiri.where(user_id: current_user.id, service_name: "タスク").paginate(page: params[:page])
    @tasks = Task.where(id: @okiniiris.pluck(:service_id)).paginate(page: params[:page]) 
  end

  def quizzes_show
    @okiniiris = Okiniiri.where(user_id: current_user.id, service_name: "クイズ").paginate(page: params[:page]) 
    @quizzes = Quiz.where(id: @okiniiris.pluck(:service_id)).paginate(page: params[:page]) 
  end

  def novels_show
    @okiniiris = Okiniiri.where(user_id: current_user.id, service_name: "小説感想").paginate(page: params[:page]) 
    @novels = Novel.where(id: @okiniiris.pluck(:service_id)).paginate(page: params[:page]) 
  end

  def mini_know_hows_show
    @okiniiris = Okiniiri.where(user_id: current_user.id, service_name: "ミニノウハウ").paginate(page: params[:page]) 
    @mini_know_hows = MiniKnowHow.where(id: @okiniiris.pluck(:service_id)).paginate(page: params[:page]) 
  end

  def praise_mes_show
    @okiniiris = Okiniiri.where(user_id: current_user.id, service_name: "ほめて！").paginate(page: params[:page]) 
    @praise_mes = PraiseMe.where(id: @okiniiris.pluck(:service_id)).paginate(page: params[:page]) 
  end

  def hyakuhyakus_show
    @okiniiris = Okiniiri.where(user_id: current_user.id, service_name: "百百").paginate(page: params[:page]) 
    @hyakuhyakus = Hyakuhyaku.where(id: @okiniiris.pluck(:service_id)).paginate(page: params[:page]) 
  end

  def five_percentage_reviews_show
    @okiniiris = Okiniiri.where(user_id: current_user.id, service_name: "５％レビュー").paginate(page: params[:page]) 
    @five_percentage_reviews = FivePercentageReview.where(id: @okiniiris.pluck(:service_id)).paginate(page: params[:page]) 
  end

  def one_yen_articles_show
    @okiniiris = Okiniiri.where(user_id: current_user.id, service_name: "１円記事").paginate(page: params[:page]) 
    @one_yen_articles = OneYenArticle.where(id: @okiniiris.pluck(:service_id)).paginate(page: params[:page]) 
  end

  def novel_services_show
    @okiniiris = Okiniiri.where(user_id: current_user.id, service_name: "小説のおまけ").paginate(page: params[:page]) 
    @novel_services = NovelService.where(id: @okiniiris.pluck(:service_id)).paginate(page: params[:page]) 
  end

  def users_show
    @okiniiris = Okiniiri.where(user_id: current_user.id, service_name: "ユーザー").paginate(page: params[:page]) 
    @users = User.where(id: @okiniiris.pluck(:service_id)).order(dice_point: :desc).paginate(page: params[:page]) 
  end
end
