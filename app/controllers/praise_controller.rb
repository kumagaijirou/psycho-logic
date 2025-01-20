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

  def comment_adopt
    @praise_me = PraiseMe.find(params[:praise_me_id])
    @praise = Praise.find(params[:praise_id])
    @praise.adopt = true
    @praise.save!
    @praise_me.rest_number_of_people -= 1
    @praise_me.save!
    if @praise_me.rest_number_of_people == 0
      @praise_me.phase = "公開中"
      @praise_me.save!
    end
    usera = User.find(@praise.user.id)
    usera.dice_point += 950
    usera.save!
        PointLog.create({
          user_id: @praise.user.id,
          service_name: "ほめて！",
          category: "相手を褒めた料金",
          dice_point: 950,
          service_id: @praise_me.id }
        )

      userb = User.find(1)
      userb.dice_point += 50
      userb.save!
        PointLog.create({
          user_id: 1,
          service_name: "ほめて！",
          category: "相手を褒めた手数料",
          dice_point: 50,
          service_id: @praise_me.id }
        )
    redirect_to praise_me_path(@praise_me[:id])
  end

  private
  def praise_params
    params.require(:praise).permit(:praise_comment)
  end
end
