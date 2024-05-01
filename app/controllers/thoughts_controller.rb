class ThoughtsController < ApplicationController

  def create
    @thought = Thought.new(
    thoughts: params[:thoughts],
    novel_id: params[:novel_id],
    user_id: current_user.id,
    )
    if @thought.save!
      redirect_to novel_path(@novel_id)
    else
      flash.now[:alert] = "問題と答えがないとクイズはできません"
      render 'new', status: :unprocessable_entity
    end
  end

  def new
    @thought = Thought.new
  end
end
