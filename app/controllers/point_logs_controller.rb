class PointLogsController < ApplicationController

  def create
    @point_logs = PointLog.new(
          user_id: params[:user_id],
          service_name: "その他",
          category: params[:category],
          dice_point: params[:dice_point]
    )
    if @point_logs.save
    @user = User.find_by(id: @point_logs.user_id)
    @user.dice_point = @user.dice_point + @point_logs.dice_point
    @user.save
      redirect_to root_url  
    end
  end

  def show
    @user = User.find(params[:id])
    @point_logs = PointLog.where(user_id: current_user.id)
  end


  private

  def point_plus_params
    params.require(:point_plus).permit(:user_id,:category,:dice_point)
  end
end
