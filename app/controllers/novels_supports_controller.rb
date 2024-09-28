class NovelsSupportsController < ApplicationController
  def create
    @novel = Novel.find(params[:novel_id])
    @novels_support = NovelsSupport.new(
      novel_id: @novel.id,
      comment: params[:novels_support][:comment],
      user_id: current_user.id,
      support_fee: params[:novels_support][:support_fee]
    )
    if @novels_support.support_fee < @current_user.dice_point
      @current_user.dice_point = @current_user.dice_point - @novels_support.support_fee
      @current_user.save
      @novels_support.save
        PointLog.create({
          user_id: current_user.id,
          service_name: "小説感想",
          category: "小説の応援の費用",
          dice_point: -@novels_support.support_fee,
          service_id: @novels_support.id }
        )
      @novel.accumulation_dice_point += @novels_support.support_fee
      @novel.save
      usera = User.find(@novel.user_id)
      usera.dice_point += @novels_support.support_fee * 0.9
      usera.save
        PointLog.create({
          user_id: @novel.user_id,
          service_name: "小説感想",
          category: "小説の応援されたポイント",
          dice_point: @novels_support.support_fee * 0.9,
          service_id: @novels_support.id }
        )

      userb = User.find(1)
      userb.dice_point += @novels_support.support_fee * 0.1
        PointLog.create({
          user_id: 1,
          service_name: "小説感想",
          category: "小説の応援されたポイントの手数料",
          dice_point: @novels_support.support_fee * 0.1,
          service_id: @novels_support.id }
        )
        redirect_to novel_path(@novel[:id])
    else
      flash.now[:alert] = "ダイスが足りません。"
      render 'new', status: :unprocessable_entity
    end
  end

  def new
    @novel = Novel.find(params[:novel_id])
    @novels_support = NovelsSupport.new
  end


  def show
    @novel = Novel.find(params[:id])
    @novels_support = NovelsSupport.find(params[:id])
  end


  def index
    @novel = Novel.find(params[:id])
  end

private

  def novels_support_params
    params.require(:novels_support).permit(:novel_id,:comment,:support_fee)
  end
end
