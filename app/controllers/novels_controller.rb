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
    if @novel.save!
      redirect_to novel_path(@novel.id)
    else
      flash.now[:alert] = "問題と答えがないとクイズはできません"
      render 'new', status: :unprocessable_entity
    end
  end
  
  def index
    @novels = Novel.all.paginate(page: params[:page])
  end

  def show
    @novel = Novel.find(params[:novels_id]) 
    @thoughts = @novel.thoughts
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
