class PraiseMesController < ApplicationController

  def create
    @praise_me = PraiseMe.new(
      comment: params[:comment],
      number_of_people: params[:number_of_people],
      rest_number_of_people: params[:number_of_people],
      deadline: params[:deadline],
      user_id: current_user.id,
      phase: 'ほめて！'
      )

      if @praise_me.deadline.nil?
        flash.now[:alert] ="締切には今日の今以降の時間を入力してください。"
        render 'new', status: :unprocessable_entity
      elsif @praise_me.number_of_people * 1000 <= @current_user.dice_point
        @current_user.dice_point = @current_user.dice_point - @praise_me.number_of_people * 1000
        @current_user.save!
        @praise_me.save!
        PointLog.create({
            user_id: current_user.id,
            service_name: "ほめて！",
            category: "ほめる人数の設定",
            dice_point: -1000 * @praise_me.number_of_people,
            service_id: @praise_me.id }
          )
        redirect_to praise_mes_path(praise_me_id: @praise_me.id)
      
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
    @favorite = Favorite.where(user_id: current_user.id, service_name: "ほめて！" , service_id: @praise_me.id)
  end

  def new
    @praise_me = PraiseMe.new
  end

  def rest0
  @praise_me = PraiseMe.find(params[:praise_me_id])
  @user = current_user
  @user.dice_point = @user.dice_point + @praise_me.rest_number_of_people * 1000
  @user.save!
  PointLog.create({
    user_id: current_user.id,
    service_name: "ほめて！",
    category: "ほめてくれた人数が足りなかった分",
    dice_point: @praise_me.rest_number_of_people * 1000,
    service_id: @praise_me.id }
  )
  @praise_me.phase = "公開中"
  @praise_me.save!
  redirect_to praise_me_path(@praise_me[:id])
  end

  def search
  end

  def search_result
    @range = params[:range]
    if @range == "praise_me_id"
      @praise_mes = PraiseMe.where(id:params[:id_number]).paginate(page: params[:page])
    else
      @praise_mes = PraiseMe.where(user_id:params[:id_number]).paginate(page: params[:page])
    end
  end

  def favorites_delete
    @praise_me = PraiseMe.find(params[:id])
    Favorite.where(user_id: current_user.id, service_name: "ほめて！" , service_id: @praise_me.id).destroy_all
    redirect_to praise_mes_path(@praise_me[:id])
  end

  def favorites_add
    @praise_me = PraiseMe.find(params[:id])
    Favorite.create({
      user_id: current_user.id,
      service_name: "ほめて！",
      service_id: @praise_me.id}
    )
    redirect_to praise_me_path(@praise_me[:id])
  end

end
