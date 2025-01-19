class PraiseController < ApplicationController

  def create
    @praise_me = PraiseMe.find(params[:praise_me_id])
    @praise = Praise.new(
      praise_me_id: @praise_me.id,
      praise_comment: params[:praise][:praise_comment],
      user_id: current_user.id,
      adopt: false
      )
    if @praise.save 
      redirect_to praise_me_path(@praise_me[:id])
    end
  end

  def new
    @praise_me = PraiseMe.find(params[:praise_me_id])
    @praise = Praise.new
  end


  private
  def praise_params
    params.require(:praise).permit(:praise_comment)
  end
end
