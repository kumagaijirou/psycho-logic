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
    status: params[:status]
    )
    if @novel.status * 2000 <= @current_user.dice_point
      @current_user.dice_point = @current_user.dice_point - @novel.status * 2000
      @current_user.save
      @novel.save!
      PointLog.create({
          user_id: @current_user.id,
          service_name: "小説感想",
          category: "#{@novel.status}個の小説の感想を募集",
          dice_point: -2000 * @novel.status }
        )
      redirect_to novel_path(@novel.id)
    else
      flash.now[:alert] = "ダイスポイントが足りません"
      render 'new', status: :unprocessable_entity
    end
  end
  
  def index
    @novels = Novel.all.paginate(page: params[:page])
  end

  def show
    @novel = Novel.find(params[:novel_id]) 
    @thoughts = @novel.thoughts
    @thought1 = Thought.find_by(user_id: current_user.id)
    @thought = @novel.thoughts.find_by(user_id: current_user.id) if current_user
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
