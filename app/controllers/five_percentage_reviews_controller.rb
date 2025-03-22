class FivePercentageReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create,:edit, :update,]
  #before_action :correct_user,   only: [:edit, :update]

  def create
    @five_percentage_review = FivePercentageReview.new(
    user_id: current_user.id,
    service_name: params[:service_name],
    url: params[:url],
    price: params[:price],
    price_supplement: params[:price_supplement],
    status: params[:status],
    content: params[:content],
    )
    if @five_percentage_review.save
      redirect_to five_percentage_reviews_path
    else
      flash.now[:alert] = "ダイスが足りません。"
      render 'new', status: :unprocessable_entity
    end

  end
  
  def index
    @five_percentage_reviews = FivePercentageReview.all.paginate(page: params[:page])
  end

  def index2
    @five_percentage_reviews = FivePercentageReview.all.paginate(page: params[:page])
  end

  def edit
    @five_percentage_review = FivePercentageReview.find(params[:five_percentage_review_id])
  end

  def update
    @five_percentage_review = FivePercentageReview.find(params[:five_percentage_review_id])
    if @five_percentage_review.update!(update_params)
      # 更新に成功した場合を扱う
      redirect_to five_percentage_review_path(@five_percentage_review)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def show
    @usera = current_user
    @five_percentage_review = FivePercentageReview.find(params[:five_percentage_review_id])
    @favorite = Favorite.where(user_id: current_user.id, service_name: "５％レビュー" , service_id: @five_percentage_review.id)
    @point_log = PointLog.find_by(user_id: current_user.id,service_name: "５％レビュー",service_id:@five_percentage_review.id)
    if PointLog.find_by(user_id: current_user.id,service_name: "５％レビュー",service_id:@five_percentage_review.id).present?
    elsif @five_percentage_review.user_id == current_user.id  
    elsif @usera.dice_point >=  @five_percentage_review.price / 2
      @usera.dice_point = @usera.dice_point - @five_percentage_review.price / 2
      @usera.save
      @point_log = PointLog.create({
          user_id: @usera.id,
          service_name: "５％レビュー",
          category: "閲覧料",
          dice_point: -@five_percentage_review.price / 2, 
          service_id: @five_percentage_review.id,}
          )
      @userb = User.find(@five_percentage_review.user_id)
      @userb.dice_point = @userb.dice_point + @five_percentage_review.price * 45 / 100
      @userb.save
        PointLog.create({
          user_id: @userb.id,
          service_name: "５％レビュー",
          category: "閲覧された対価",
          dice_point: @five_percentage_review.price * 45 / 100, 
          service_id: @five_percentage_review.id,}
          )
      @userc = User.find(1)
      @userc.dice_point = @userc.dice_point + @five_percentage_review.price / 20
      @userc.save
      PointLog.create({
          user_id: @userc.id,
          service_name: "５％レビュー",
          category: "閲覧された対価の手数料",
          dice_point: @five_percentage_review.price / 20, 
          service_id: @five_percentage_review.id,}
          )
    end
  end

  def search
  end

  def search_result
    @range = params[:range]
    if @range == "five_percentage_review_id"
      @five_percentage_reviews = FivePercentageReview.where(id:params[:id_number]).paginate(page: params[:page])
    else
      @five_percentage_reviews = FivePercentageReview.where(user_id:params[:id_number]).paginate(page: params[:page])
    end
  end

  def favorites_delete
    @five_percentage_review = FivePercentageReview.find(params[:five_percentage_review_id])
    Favorite.where(user_id: current_user.id, service_name: "５％レビュー" , service_id: @five_percentage_review.id).destroy_all
    redirect_to five_percentage_reviews_path(@five_percentage_review[:five_percentage_review_id])
  end

  def favorites_add
    @five_percentage_review = FivePercentageReview.find(params[:five_percentage_review_id])
    Favorite.create({
      user_id: current_user.id,
      service_name: "５％レビュー",
      service_id: @five_percentage_review.id}
    )
    redirect_to five_percentage_reviews_path(@five_percentage_review[:five_percentage_review_id])
  end

  private

  def update_params
    params.require(:five_percentage_review).permit(:service_name,:url,:price,:price_supplement,:status,:content)
  end

  def five_percentage_review_params
    params.require(:five_percentage_review).permit(:user_id,:service_name,:url,:price,:price_supplement,:status,:content)
  end

        # beforeフィルタ

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url, status: :see_other
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
