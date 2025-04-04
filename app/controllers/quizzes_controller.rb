class QuizzesController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]

  def create
    @quiz = Quiz.new(
    question: params[:question],
    answer: params[:answer],
    user_id: current_user.id,
    number_of_times_solved: 0,
    number_of_correct_answers: 0,
    number_of_times_we_saw_the_answer: 0
    )
    if @quiz.save!
      redirect_to quizzes_path(@quiz[:id])
    else
      flash.now[:alert] = "問題と答えがないとクイズはできません"
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @quizzes = Quiz.where(user_id: current_user.id).paginate(page: params[:page])
  end

  def index_all
    @quizzes = Quiz.all.paginate(page: params[:page])

  end
  
  def show
    @quiz = Quiz.find(params[:quizzes_id])
  end
  
  def new
    @quiz = Quiz.new
  end

  def search
  end

  def search_result
    @range = params[:range]
    if @range == "quiz_id"
      @quizzes = Quiz.where(id:params[:id_number]).paginate(page: params[:page])
    else
      @quizzes = Quiz.where(user_id:params[:id_number]).paginate(page: params[:page])
    end
  end

  def okiniiris_delete
    @quiz = Quiz.find(params[:id])
    Okiniiri.where(user_id: current_user.id, service_name: "クイズ" , service_id: @quiz.id).destroy_all
    redirect_to quizzes_path(@quiz[:id])
  end

  def okiniiris_add
    @quiz = Quiz.find(params[:id])
    Okiniiri.create({
      user_id: current_user.id,
      service_name: "クイズ",
      service_id: @quiz.id}
    )
    redirect_to quizzes_path(@quiz[:id])
  end

  def answer
    @quiz = Quiz.find(params[:quizzes_id])
    @user = User.find(current_user.id)
    @okiniiri = Okiniiri.where(user_id: current_user.id, service_name: "クイズ" , service_id: @quiz.id)
  end

  def create_answer
    @quiz = Quiz.find(params[:quizzes_id])
    @quiz.number_of_times_solved = @quiz.number_of_times_solved + 1
    @quiz.save!
    @user = User.find(current_user.id)
    if @user.update!(user_params)
      redirect_to quizzes_answer_result_path(@quiz)
    else

    end
  end

  def answer_result
    @quiz = Quiz.find(params[:quizzes_id])
    @user = User.find(current_user.id) 
  end

  def see_answer
    @quiz = Quiz.find(params[:quizzes_id])
    @user = User.find(current_user.id) 
    @user1 = User.find(1)
    @quiz.number_of_times_we_saw_the_answer = @quiz.number_of_times_we_saw_the_answer + 1
    @quiz.save!
    if @user.dice_point > 100
      # 問題作成者と答えを見たユーザーが同じ場合
      if @quiz.user.id == @user.id
        net_change = 90 - 100
        @user.dice_point += net_change
        @user.save!
        PointLog.create({
          user_id: @quiz.user_id,
          service_name: "クイズ",
          category: "制作した問題の答え閲覧",
          dice_point: 90,
          service_id: @quiz.id }
        )
        PointLog.create({
          user_id: current_user.id,
          service_name: "クイズ",
          category: "答えの閲覧",
          dice_point: -100,
          service_id: @quiz.id }
        )
        @user1.dice_point += 10
        @user1.save!
        PointLog.create({
          user_id: 1,
          service_name: "クイズ",
          category: "答えの閲覧手数料",
          dice_point: 10,
          service_id: @quiz.id }
        )
      else
        # @quiz.user と @user が異なる場合
        @quiz.user.dice_point += 90
        @quiz.user.save!
        PointLog.create({
          user_id: @quiz.user_id,
          service_name: "クイズ",
          category: "制作した問題の答え閲覧",
          dice_point: 90,
          service_id: @quiz.id }
        )
        @user.dice_point -= 100
        @user.save!
        PointLog.create({
          user_id: current_user.id,
          service_name: "クイズ",
          category: "答えの閲覧",
          dice_point: -100,
          service_id: @quiz.id }
        )
        @user1.dice_point += 10
        @user1.save!
        PointLog.create({
          user_id: 1,
          service_name: "クイズ",
          category: "答えの閲覧手数料",
          dice_point: 10,
          service_id: @quiz.id }
        )
      end
    else 
    end
  end

  def edit
    @quiz = Quiz.find(params[:quizzes_id])
  end

  def update
    @quiz = Quiz.find(params[:quizzes_id])
    if @quiz.update(update_params)
      flash[:success] = "問題を変更しました。"
      redirect_to quiz_path(quizzes_id: @quiz.id)
    else
      flash.now[:danger] = "編集に失敗しました"
      render 'edit', status: :unprocessable_entity
    end
  end


  private

  def quiz_params
    params.permit(:question, :answer)
  end

  def user_params
    params.permit(:final_answer)
  end

  def update_params
    params.require(:quiz).permit(:question, :answer)
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