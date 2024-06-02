class ThoughtsController < ApplicationController

  def create
    @novel = Novel.find(params[:novel_id])
    @thought = Thought.new(thoughts: "現在感想の予約中です。")
    @thought.novel_id = @novel.id
    @thought.user_id = current_user.id
    if @thought.save!
    else
      flash.now[:alert] = "問題と答えがないとクイズはできません"
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    @novel = Novel.find(params[:novel_id])
    Rails.logger.debug params.inspect
      @thought = Thought.find(params[:thought_id])
      if @thought.update!(update_params)
        redirect_to @thought
      else
        render :edit
      end
    if #@thought.save!
      #@novel.status = @novel.status - 1 
      @novel.save!
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

private
def update_params
  params.require(:thought).permit(:thought)
end