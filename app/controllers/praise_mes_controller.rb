class PraiseMesController < ApplicationController

  def create
    @praise_me = PraiseMe.new(
      comment: params[:comment],
      number_of_people: params[:number_of_people],
      deadline: params[:deadline],
      user_id: current_user.id,
      phase: 'ほめて！'
      )
      if @praise_me.deadline.nil?
        flash.now[:alert] ="今日の今以降の時間を入力してください。"
        render 'new', status: :unprocessable_entity
      elsif @praise_me.number_of_people * 1000 <= @current_user.dice_point
        @current_user.dice_point = @current_user.dice_point - @praise_me.number_of_people * 1000
        @current_user.save!
        @praise_me.save!
        PointLog.create({
            user_id: current_user.id,
            service_name: "ほめて！",
            category: "ほめる人数の設定",
            dice_point: -@praise_me.number_of_people * 1000,
            service_id: @praise_me.id }
          )
        redirect_to praise_me_path(@praise_me)
      
      else
        flash.now[:alert] = "ダイスが足りません。"
        render 'new', status: :unprocessable_entity
      end
  end


  def index
    @praise_mes = PraiseMe.all.paginate(page: params[:page])
  end

  def show
    @praise_me = PraiseMe.find(params[:id])
    @praises = @praise_me.praises
  end

  def new
    @praise_me = PraiseMe.new
  end


end
