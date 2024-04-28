class QuizzesController < ApplicationController
  #before_action :logged_in_user, only: [:create, :index, :edit, :update, :destroy]

  def create
    @quiz = Quiz.new(
    question: params[:question],
    answer: params[:answer],
    user_id: current_user.id
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

  private

  def quiz_params
    params.permit(:quizzes => [:question, :answer])
  end

  def user_params
    params.permit(:final_answer)
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