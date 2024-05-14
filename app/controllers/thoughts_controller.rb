class ThoughtsController < ApplicationController

  def create
    @novel = Novel.find(params[:novel_id])
    @thought = Thought.new(
      thoughts: params[:thoughts],
      novel_id: @novel.id,
      user_id: current_user.id,
    )
    if @thought.save!
      redirect_to novel_path(@novel)
    else
      flash.now[:alert] = "問題と答えがないとクイズはできません"
      render 'new', status: :unprocessable_entity
    end
  end

  def new
    @novel = Novel.find(params[:novel_id])
    @thought = Thought.new
  end
end
