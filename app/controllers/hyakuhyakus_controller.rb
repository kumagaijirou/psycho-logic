class HyakuhyakusController < ApplicationController

  def create
    @hyakuhyaku = Hyakuhyaku.new(
    user_id: current_user.id,
    front_comment: params[:front_comment],
    back_comment: params[:back_comment],
    number_of_times_seen: 0,
    number_of_refunds: 0
    )
    if @hyakuhyaku.save
      redirect_to hyakuhyakus_path
    else
      flash.now[:alert] = "ダイスが足りません。"
      render 'new', status: :unprocessable_entity
    end
  end
  
  def index
    @hyakuhyakus = Hyakuhyaku.all.paginate(page: params[:page])
  end

  def show
    @usera = current_user
    @hyakuhyaku = Hyakuhyaku.find((params[:id]))
    @okiniiri = Okiniiri.where(user_id: current_user.id, service_name: "百百" , service_id: @hyakuhyaku.id)
    @point_log = PointLog.find_by(user_id: current_user.id,service_name: "百百",service_id:@hyakuhyaku.id)
    if PointLog.find_by(user_id: current_user.id,service_name: "百百",service_id:@hyakuhyaku.id).present?
    elsif @hyakuhyaku.user_id == current_user.id  
    elsif @usera.dice_point >=  50
      @usera.dice_point = @usera.dice_point - 50
      @usera.save
      @point_log = PointLog.create({
          user_id: @usera.id,
          service_name: "百百",
          category: "閲覧料",
          dice_point: -50, 
          service_id: @hyakuhyaku.id,}
          )
      @userb = User.find(@hyakuhyaku.user_id)
      @userb.dice_point = @userb.dice_point + 45
      @userb.save
        PointLog.create({
          user_id: @userb.id,
          service_name: "百百",
          category: "閲覧された対価",
          dice_point: 45, 
          service_id: @hyakuhyaku.id,}
          )
      @userc = User.find(1)
      @userc.dice_point = @userc.dice_point + 5
      @userc.save
      PointLog.create({
          user_id: @userc.id,
          service_name: "百百",
          category: "閲覧された対価の手数料",
          dice_point: 5, 
          service_id: @hyakuhyaku.id,}
          )
      @hyakuhyaku.number_of_times_seen += 1
      @hyakuhyaku.save
    end
  end

  def search
  end

  def search_result
    @range = params[:range]
    if @range == "hyakuhyaku_id"
      @hyakuhyakus = Hyakuhyaku.where(id:params[:id_number]).paginate(page: params[:page])
    else
      @hyakuhyakus = Hyakuhyaku.where(user_id:params[:id_number]).paginate(page: params[:page])
    end
  end

  def okiniiris_delete
    @hyakuhyaku = Hyakuhyaku.find(params[:id])
    Okiniiri.where(user_id: current_user.id, service_name: "百百" , service_id: @hyakuhyaku.id).destroy_all
    redirect_to hyakuhyaku_path(@hyakuhyaku[:id])
  end

  def okiniiris_add
    @hyakuhyaku = Hyakuhyaku.find(params[:id])
    Okiniiri.create({
      user_id: current_user.id,
      service_name: "百百",
      service_id: @hyakuhyaku.id}
    )
    redirect_to hyakuhyaku_path(@hyakuhyaku[:id])
  end

end
