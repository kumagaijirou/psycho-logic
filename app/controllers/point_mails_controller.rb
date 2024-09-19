class PointMailsController < ApplicationController

  def create
    @point_mail = PointMail.new(
    user_id: current_user.id,
    send_user_id: params[:send_user_id],
    send_user_email: params[:send_user_email],
    title: params[:title],
    content: params[:content],
    send_dice_point: params[:send_dice_point],
    send_date: params[:send_date],
    open: false
    )
    if @point_mail.send_dice_point <= @current_user.dice_point
      @current_user.dice_point = @current_user.dice_point - @point_mail.send_dice_point
      @current_user.save
      @point_mail.save
      PointLog.create({
          user_id: current_user.id,
          service_name: "メール",
          category: "ポイント送付メールの作成",
          dice_point: -@point_mail.send_dice_point }
        )
      redirect_to point_mails_path(@point_mail[:id])
    else
      flash.now[:alert] = "ダイスが足りません。"
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @point_mails = PointMail.where(send_user_id: current_user.id).paginate(page: params[:page])
  end

  def index2
    @point_mails = PointMail.where(user_id: current_user.id).paginate(page: params[:page])
  end

  def new
    @point_mail = PointMail.new
  end

  def show
    @point_mail = PointMail.find((params[:id]))
    @user = current_user
    if @point_mail.open == false
    @user.dice_point = @user.dice_point + @point_mail.send_dice_point
    @user.save
    @point_mail.open = true
    @point_mail.save
    PointLog.create({
          user_id: @user.id,
          service_name: "メール",
          category: "ポイント送付メールの受け取り",
          dice_point: @point_mail.send_dice_point }
          )
    end
  end
end
