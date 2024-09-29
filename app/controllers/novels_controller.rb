class NovelsController < ApplicationController
  #before_action :logged_in_user, only: [:create, :index, :edit, :update, :destroy]
  
  def create
    @novel = Novel.new(
    work_name: params[:work_name],
    synopsis: params[:synopsis],
    url1: params[:url1],
    url2: params[:url2],
    url3: params[:url3],
    user_id: current_user.id,
    status: params[:status],
    accumulation_dice_point: 0,
    )
    if @novel.status * 2000 <= @current_user.dice_point
      @current_user.dice_point = @current_user.dice_point - @novel.status * 2000
      @current_user.save
      @novel.save!
      PointLog.create({
          user_id: @current_user.id,
          service_name: "小説感想",
          category: "#{@novel.status}個の小説の感想を募集",
          dice_point: -2000 * @novel.status,
          service_id: @novel.id }
        )
      redirect_to novel_path(@novel.id)
    else
      flash.now[:alert] = "ダイスポイントが足りません"
      render 'new', status: :unprocessable_entity
    end
  end

  def search
  end

  def search_result
    @range = params[:range]
    if @range == "novel_id"
      @novels = Novel.where(id:params[:id_number]).paginate(page: params[:page])
    else
      @novels = Novel.where(user_id:params[:id_number]).paginate(page: params[:page])
    end
  end

  
  def favorites_delete
    @novel = Novel.find(params[:id])
    Favorite.where(user_id: current_user.id, service_name: "小説感想" , service_id: @novel.id).destroy_all
    redirect_to novels_path(@novel[:id])
  end

  def favorites_add
    @novel = Novel.find(params[:id])
    Favorite.create({
      user_id: current_user.id,
      service_name: "小説感想",
      service_id: @novel.id}
    )
    redirect_to novels_path(@novel[:id])
  end

  def index
    @novels = Novel.all.order(accumulation_dice_point: "DESC").paginate(page: params[:page])
  end

  def show
    @novel = Novel.find(params[:novel_id]) 
    @thoughts = @novel.thoughts
    @thought1 = Thought.find_by(user_id: current_user.id)
    @thought = @novel.thoughts.find_by(user_id: current_user.id) if current_user
    @favorite = Favorite.where(user_id: current_user.id, service_name: "小説感想" , service_id: @novel.id)
    @novels_supports = @novel.novels_supports
    @novels_support = NovelsSupport.find_by(user_id: current_user.id)
  end

  def status
    @novel = Novel.find(params[:id])
  end

  def update_status
    @user = current_user
    @novel = Novel.find(params[:id])
    @novel.update!(status: params[:status])
    if @user.dice_point < @novel.status * 2000
       @novel.update!(status: 0 )
       flash.now[:alert] = "ダイスが足りません。"
    else
      @user.dice_point -= @novel.status * 2000
      @user.save
      PointLog.create({
          user_id: @current_user.id,
          service_name: "小説感想",
          category: "#{@novel.status}個の小説の感想を募集",
          dice_point: -2000 * @novel.status,
          service_id: @novel.id }
        )
    end
    redirect_to novel_path(@novel[:id])
  end

  private

    def novel_params
        params.permit(:novel => [:work_name, :synopsis, :url1, :url2, :url3, :status])
      end
    
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end
  end
