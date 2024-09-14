class ThoughtsController < ApplicationController

  def create
    @novel = Novel.find(params[:novel_id])
    @thought = Thought.new(
          thoughts: params[:thoughts],
          user_id: current_user.id,
          novel_id: @novel.id
    )
    if @thought.save!
      @novel.status = @novel.status - 1 
      @novel.save!
      @thought.user.dice_point += 1900
      @thought.user.save!
      PointLog.create({
        user_id: @thought.user_id,
        service_name: "小説感想",
        category: "小説の感想を書いた",
        dice_point: 1900 }
      )
      @user1 = User.find(1)
      @user1.dice_point += 100
        @user1.save!
        PointLog.create({
          user_id: 1,
          service_name: "小説感想",
          category: "小説の感想を書いた手数料",
          dice_point: 100 }
        )
      redirect_to novel_path(@novel)
    else
      flash.now[:alert] = "問題と答えがないとクイズはできません"
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @novel = Novel.find(params[:novel_id])
    @thought = Thought.find(params[:thought_id])
  end
  
  def update
    @novel = Novel.find(params[:novel_id])
    @thought = Thought.find(params[:thought_id])
    if @thought.update!(update_params) 
        redirect_to novel_path(@novel)
    else
      render :edit
    end

  end

  def new
    @novel = Novel.find(params[:novel_id])
    @thought = Thought.new
  end

end

private
def update_params
  params.require(:thought).permit(:thoughts)
end

def thought_params
  params.require(:thought).permit(:novel_id, :thought_id, :thoughts)
end