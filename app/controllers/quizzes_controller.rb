class QuizzesController < ApplicationController
  before_action :logged_in_user, only: [:create, :index, :edit, :update, :destroy]

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
    @quiz = Quiz.find(params[:quiz_id])
  end
  
  def new
    @quiz = Quiz.new
  end

  def answer
    @quiz = Quiz.find(params[:quizzes_id])
    @user = User.find(current_user.id)
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
    @quiz.number_of_times_we_saw_the_answer = @quiz.number_of_times_we_saw_the_answer + 1
    @quiz.save!
    @quiz.user.dice_point = @quiz.user.dice_point + 90
    @quiz.user.save!
    @user.dice_point = @user.dice_point - 100
    @user.save! 
  end

  def edit
    @quiz = Quiz.find(params[:quizzes_id])
  end

  def update
    @quiz = Quiz.find(params[:quizzes_id])
    if @quiz.update(update_params)
      flash[:success] = "問題を変更しました。"
      redirect_to @quiz
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