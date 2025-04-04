class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  
  def ranking
    @users = User.all.order(dice_point: "DESC").paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @task1 = Task.where(user_id: params[@user.id], status: "成功" )
    @task2 = Task.where(user_id: params[@user.id], status: "失敗" )
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.dice_point = 0
      if @user.save && @user.final_answer == ""
        flash[:info] = "入力したアドレスで届いたメールをチェックしてアカウントを有効にして下さい。"
        @user.send_activation_email
        redirect_to root_url
      elsif @user.save
        flash[:info] = "入力したアドレスで届いたメールをチェックしてアカウントを有効にして下さい。"
        @user.send_activation_email
        point = PointCode.find_by!(code: params[:user][:final_answer], used_at: nil).point
        if point == nil
          point = 0
        else
        end
        @user.dice_point += point
        @user.save
        code = PointCode.find_by!(code: params[:user][:final_answer], used_at: nil)
        code.used_at = Time.now
        code.save
        PointLog.create({
          user_id: @user.id,
          service_name: "ポイントメール",
          category: "ポイント送付メールのポイント",
          dice_point: point,
          service_id: code.id }
        )
          @usera = User.find(code.user_id)
          @user.dice_point_expiry_date = @usera.dice_point_expiry_date
          @user.save
        redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新に成功した場合を扱う
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end

  def answer
    @quiz = Quiz.find(params[:quiz_id])
    @user = User.find(current_user.id)
    if @user.update!(user_params)
      redirect_to quizzes_answer_result_path(@quiz)
    else

    end
  end
  
  def show_probably_a_hit
    @user = User.find(params[:id])
    @probably_a_hit = ProbablyAHit.where(user_id: @user.id)
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:profile,:dice_point,
                                 :final_answer,:avatar)
    end

        # beforeフィルタ

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
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