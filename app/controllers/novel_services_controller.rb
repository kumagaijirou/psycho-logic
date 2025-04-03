class NovelServicesController < ApplicationController
  def create
    @novel_service = NovelService.new(
    user_id: current_user.id,
    title: params[:title],
    subtitle: params[:subtitle],
    url1: params[:url1],
    url2: params[:url2],
    url3: params[:url3],
    content: params[:content],
    views: 0
    )
    if @novel_service.save
      redirect_to novel_services_path
    else
      flash.now[:alert] = "ダイスが足りません。"
      render 'new', status: :unprocessable_entity
    end

  end
  
  def index
    @novel_services = NovelService.all.paginate(page: params[:page])
  end

  def index2
    @novel_services = NovelService.all.paginate(page: params[:page])
  end

  def edit
    @novel_service = NovelService.find(params[:novel_service_id])
  end

  def update
    @novel_service = NovelService.find(params[:novel_service_id])
    if @novel_service.update!(update_params)
      # 更新に成功した場合を扱う
      redirect_to novel_service_path(@novel_service)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def show
    @usera = current_user
    @novel_service = NovelService.find((params[:id]))
    @favorite = Favorite.where(user_id: current_user.id, service_name: "小説のおまけ", service_id: @novel_service.id)
    @point_log = PointLog.find_by(user_id: current_user.id,service_name: "小説のおまけ", service_id: @novel_service.id)
    if PointLog.find_by(user_id: current_user.id,service_name: "小説のおまけ",service_id:@novel_service.id,dice_point:-100).present?
    elsif @novel_service.user_id == current_user.id  
    elsif @usera.dice_point >=  100
      @usera.dice_point = @usera.dice_point - 100
      @usera.save
      @point_log = PointLog.create({
          user_id: @usera.id,
          service_name: "小説のおまけ",
          category: "閲覧料",
          dice_point: -100, 
          service_id: @novel_service.id,}
          )
      @userb = User.find(@novel_service.user_id)
      @userb.dice_point = @userb.dice_point + 90
      @userb.save
        PointLog.create({
          user_id: @userb.id,
          service_name: "小説のおまけ",
          category: "閲覧された対価",
          dice_point: 90, 
          service_id: @novel_service.id,}
          )
      @userc = User.find(1)
      @userc.dice_point = @userc.dice_point + 10
      @userc.save
      PointLog.create({
          user_id: @userc.id,
          service_name: "小説のおまけ",
          category: "閲覧された対価の手数料",
          dice_point: 10, 
          service_id: @novel_service.id,}
          )
        @novel_service.views += 1
        @novel_service.save
        @novel = Novel.find_by(work_name:@novel_service.title, user_id:@novel_service.user_id)
        if @novel.present?
        @novel.accumulation_dice_point += 100
        @novel.save
        end

      end    
  end

  def search
  end

  def search_result
    @range = params[:range]
    if @range == "novel_service_id"
      @novel_services = NovelService.where(id:params[:id_number]).paginate(page: params[:page])
    else
      @novel_services = NovelService.where(user_id:params[:id_number]).paginate(page: params[:page])
    end
  end

  def favorites_delete
    @novel_service = NovelService.find(params[:novel_service_id])
    Favorite.where(user_id: current_user.id, service_name: "小説のおまけ" , service_id: @novel_service.id).destroy_all
    redirect_to novel_services_path(@novel_service[:novel_service_id])
  end

  def favorites_add
    @novel_service = NovelService.find(params[:novel_service_id])
    Favorite.create({
      user_id: current_user.id,
      service_name: "小説のおまけ",
      service_id: @novel_service.id}
    )
    redirect_to novel_services_path(@novel_service[:novel_service_id])
  end
end
