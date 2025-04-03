class TasksController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,:status_run,:last_message]

  def create
      @task = Task.new(
      content: params[:content],
      bet_user_id: params[:bet_user_id],
      deadline_at: params[:deadline_at],
      amount_bet: params[:amount_bet],
      user_id: current_user.id,
      status: '実行中'
      )
    if @task.deadline_at.nil?
      flash.now[:alert] ="今日の今以降の時間を入力してください。"
      render 'new', status: :unprocessable_entity
    elsif @task.amount_bet <= @current_user.dice_point
      @current_user.dice_point = @current_user.dice_point - @task.amount_bet
      @current_user.save
      @task.save
      PointLog.create({
          user_id: current_user.id,
          service_name: "タスク",
          category: "タスクの設定",
          dice_point: -@task.amount_bet,
          service_id: @task.id }
        )
      redirect_to task_path(@task)
    
    else
      flash.now[:alert] = "ダイスが足りません。"
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @tasks = Task.where(user_id: current_user.id).paginate(page: params[:page])
    @task = Task.find_by(id: params[:id])
  end

  def index2
    @tasks = Task.all.paginate(page: params[:page])
  end
  
  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
    @user = User.find(@task.bet_user_id)
    @supports = @task.supports
    @favorite = Favorite.where(user_id: current_user.id, service_name: "タスク" , service_id: @task.id)
  end

  def search
  end

  def search_result
    @range = params[:range]
    if @range == "task_id"
      @tasks = Task.where(id:params[:id_number]).paginate(page: params[:page])
    else
      @tasks = Task.where(user_id:params[:id_number]).paginate(page: params[:page])
    end
  end

  def favorites_delete
    @task = Task.find(params[:id])
    Favorite.where(user_id: current_user.id, service_name: "タスク" , service_id: @task.id).destroy_all
    redirect_to tasks_path(@task[:id])
  end

  def favorites_add
    @task = Task.find(params[:id])
    Favorite.create({
      user_id: current_user.id,
      service_name: "タスク",
      service_id: @task.id}
    )
    redirect_to tasks_path(@task[:id])
  end

  def status_run
    @task = Task.find(params[:id])
    if @task.status == '実行中' && Time.now < @task.deadline_at
      @task.status = '成功'
      @task.save!
      PointLog.create({
          user_id: current_user.id,
          service_name: "タスク",
          category: "タスクの成功",
          dice_point: @task.amount_bet }
        )
      # 問題の箇所１
      # タスクに紐づく全ての応援費の合計を算出
      support_fees = 0
      @task.supports.each do |support|
        if support.present?
          support_fees += support.support_fee
          PointLog.create({
            user_id: current_user.id,
            service_name: "タスク",
            category: "タスクの成功の応援",
            dice_point: support_fees,
            service_id: @support.id  }
        )
        end
      end

      # ベットと応援費合計をcurrent_userのdice_pointに代入
      @current_user.dice_point += @task.amount_bet + support_fees
      @current_user.save

    elsif @task.status == '実行中' && Time.now > @task.deadline_at
      @task.status = '失敗'
      @task.save!
      # 問題の箇所２
      # bet_userがポイントを取得
      # bet_userはview側で使う必要のない変数のため、パフォーマンスの観点からローカル変数で定義している
      # nilの場合は+を使うとエラーとなるため、そのまま値を代入
      bet_user_id = @task.bet_user_id
      bet_user = User.find(bet_user_id)
      bet_user.dice_point = bet_user.dice_point.present? ? bet_user.dice_point + @task.amount_bet : @task.amount_bet
      bet_user.save!
      PointLog.create({
          user_id: @task.bet_user_id,
          service_name: "タスク",
          category: "賭けていたタスクの失敗",
          dice_point: @task.amount_bet,
          service_id: @task.id  }
          )
      @task.supports.each do |support|
        if support.present?
          support_user_id = support.user_id
          support_user = User.find(support_user_id)
          if support.present?
            support_user.dice_point = support_user.dice_point.present? ? support_user.dice_point + support.support_fee : support.support_fee
            PointLog.create({
          user_id: support.user_id,
          service_name: "タスク",
          category: "応援したタスクの失敗",
          dice_point: support.support_fee,
          service_id: support.id  }
          )
          end
        end
        support_user.save!
      end
      @user = User.find(@task.bet_user_id)
      if @user.dice_point_expiry_date.nil?
        @usera = User.find(@task.user_id)
        @user.dice_point_expiry_date = @usera.dice_point_expiry_date
        @user.save
      end
    else
    end

    @task.last_time_at = Time.now
    @task.save
    redirect_to task_path(@task[:id])
  end

  def candidate
    @task = Task.find(params[:id])
    @task.update(bet_user_id: current_user.id) 
    @task.save!
    redirect_to task_path(@task[:id])
    flash[:notice] = "ダイスをもらえる権利に立候補しました。"
  end

  def last_message
    @task = Task.find(params[:id])
  end

  def update_last_message
    @task = Task.find(params[:id])
    @task.update!(last_message: params[:last_message])
    redirect_to task_path(@task[:id])
  end
end


private

  def task_params
    params.require(:task).permit(:content,:bet_user_id,:user_id,
                                :deadline_at,:amount_bet,:status,
                                :last_time_at,:last_message,:image)
  end

 # ログイン済みユーザーかどうか確認
 def logged_in_user
  unless logged_in?
    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url, status: :see_other
  end
end