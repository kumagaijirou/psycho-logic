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
    @user.referred_user_id = params[:referred_user_id]
  end

  def create
    @user = User.new(user_params)
    @user.dice_point = 1000
  
    if @user.save && @user.final_answer.blank?
      flash[:info] = "入力したアドレスで届いたメールをチェックしてアカウントを有効にして下さい。"
      @user.send_activation_email
      handle_referral(@user)
      redirect_to root_url
  
    elsif @user.save
      flash[:info] = "入力したアドレスで届いたメールをチェックしてアカウントを有効にして下さい。"
      @user.send_activation_email
  
      code = PointCode.find_by(code: params[:user][:final_answer], used_at: nil)
      point = code&.point || 0
  
      @user.increment!(:dice_point, point)
  
      if code
        code.update!(used_at: Time.current)
        PointLog.create!(
          user_id: @user.id,
          service_name: "ポイントメール",
          category: "ポイント送付メールのポイント",
          dice_point: point,
          service_id: code.id
        )
      end
  
      handle_referral(@user)
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
    flash[:success] = "ユーザーを消去しました。"
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
      params.require(:user).permit(
        :name, :email, :password, :password_confirmation,
        :final_answer, :referred_user_id, # ← これ絶対必要！！
        :avatar
      )
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

    def handle_referral(user)
      if user.referred_user_id.present?
        referred_user = User.find_by(id: user.referred_user_id)
        if referred_user
          referred_user.increment!(:dice_point, 2000)
          PointLog.create!(
            user_id: referred_user.id,
            service_name: "その他",
            category: "紹介したユーザーの入会",
            dice_point: 2000,
            service_id: user.id
          )
        end
      end
    end
  end