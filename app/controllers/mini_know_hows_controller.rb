class MiniKnowHowsController < ApplicationController

  def create
    @mini_know_how = MiniKnowHow.new(
    user_id: current_user.id,
    title: params[:title],
    content: params[:content],
    viewing_fee: params[:viewing_fee],
    number_of_times_seen: 0,
    number_of_refunds: 0
    )
    if @mini_know_how.save
      redirect_to mini_know_hows_path
    else
      flash.now[:alert] = "ダイスが足りません。"
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @mini_know_hows = MiniKnowHow.all.paginate(page: params[:page])
  end



  def new
    @mini_know_how = MiniKnowHow.new
  end

  def show
    @usera = current_user
    @mini_know_how = MiniKnowHow.find((params[:id]))
    @okiniiri = Okiniiri.where(user_id: current_user.id, service_name: "ミニノウハウ" , service_id: @mini_know_how.id)
    if PointLog.find_by(user_id: current_user.id,service_name: "ミニノウハウ",service_id:@mini_know_how.id).present?
      @point_log = PointLog.find_by(user_id: current_user.id,service_name: "ミニノウハウ",service_id:@mini_know_how.id)
    elsif @usera.dice_point >=  @mini_know_how.viewing_fee
      @usera.dice_point = @usera.dice_point - @mini_know_how.viewing_fee
      @usera.save
      @point_log = PointLog.create({
          user_id: @usera.id,
          service_name: "ミニノウハウ",
          category: "閲覧料",
          dice_point: -@mini_know_how.viewing_fee, 
          service_id: @mini_know_how.id,}
          )
      @userb = User.find(@mini_know_how.user_id)
      @userb.dice_point = @userb.dice_point + @mini_know_how.viewing_fee * 0.9
      @userb.save
        PointLog.create({
          user_id: @userb.id,
          service_name: "ミニノウハウ",
          category: "閲覧された対価",
          dice_point: @mini_know_how.viewing_fee * 0.9, 
          service_id: @mini_know_how.id,}
          )
      @userc = User.find(1)
      @userc.dice_point = @userc.dice_point + @mini_know_how.viewing_fee * 0.1
      @userc.save
      PointLog.create({
          user_id: @userc.id,
          service_name: "ミニノウハウ",
          category: "閲覧された対価の手数料",
          dice_point: @mini_know_how.viewing_fee * 0.1, 
          service_id: @mini_know_how.id,}
          )
      @mini_know_how.number_of_times_seen += 1
      @mini_know_how.save
    end
  end

  def search
  end

  def search_result
    @range = params[:range]
    if @range == "mini_know_how_id"
      @mini_know_hows = MiniKnowHow.where(id:params[:id_number]).paginate(page: params[:page])
    else
      @mini_know_hows = MiniKnowHow.where(user_id:params[:id_number]).paginate(page: params[:page])
    end
  end

  def okiniiris_delete
    @mini_know_how = MiniKnowHow.find(params[:id])
    Okiniiri.where(user_id: current_user.id, service_name: "ミニノウハウ" , service_id: @mini_know_how.id).destroy_all
    redirect_to mini_know_hows_path(@mini_know_how[:id])
  end

  def okiniiris_add
    @mini_know_how = MiniKnowHow.find(params[:id])
    Okiniiri.create({
      user_id: current_user.id,
      service_name: "ミニノウハウ",
      service_id: @mini_know_how.id}
    )
    redirect_to mini_know_hows_path(@mini_know_how[:id])
  end

end