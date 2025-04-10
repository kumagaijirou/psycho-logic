class AudioReadingsController < ApplicationController
  before_action :set_audio_reading, only: [:show, :edit, :update, :destroy]

  def index
    @audio_readings = AudioReading.all.paginate(page: params[:page])
  end

  def show
    @usera = current_user
    @audio_reading = AudioReading.find((params[:id]))
    @okiniiri = Okiniiri.where(user_id: current_user.id, service_name: "小説朗読" , service_id: @audio_reading.id)
    @point_log = PointLog.find_by(user_id: current_user.id,service_name: "小説朗読",service_id:@audio_reading.id)
    if PointLog.find_by(user_id: current_user.id,service_name: "小説朗読",service_id:@audio_reading.id).present?
    elsif @audio_reading.user_id == current_user.id  
    elsif @usera.dice_point >=  100
      @usera.dice_point = @usera.dice_point - 100
      @usera.save
      @point_log = PointLog.create({
          user_id: @usera.id,
          service_name: "小説朗読",
          category: "朗読の聴取料",
          dice_point: -100, 
          service_id: @audio_reading.id,}
          )
      @userb = User.find(@audio_reading.user_id)
      @userb.dice_point = @userb.dice_point + 70
      @userb.save
        PointLog.create({
          user_id: @userb.id,
          service_name: "小説朗読",
          category: "聴取された対価",
          dice_point: 70, 
          service_id: @audio_reading.id,}
          )
      @userc = User.find(@audio_reading.author_user_id)
      @userc.dice_point = @userc.dice_point + 20
      @userc.save
        PointLog.create({
          user_id: @userc.id,
          service_name: "小説朗読",
          category: "小説の朗読された対価",
          dice_point: 20, 
          service_id: @audio_reading.id,}
          )
      @userd = User.find(1)
      @userd.dice_point = @userc.dice_point + 10
      @userd.save
      PointLog.create({
          user_id: @userc.id,
          service_name: "小説朗読",
          category: "閲覧された対価の手数料",
          dice_point: 5, 
          service_id: @audio_reading.id,}
          )
      @audio_reading.play_count += 1
      @audio_reading.save
      @novel = Novel.find_by(work_name:@audio_reading.title, user_id:@audio_reading.author_user_id)
        if @novel.present?
        @novel.accumulation_dice_point += 100
        @novel.save
        end
    end
  end

  def new
    @audio_reading = AudioReading.new
  end

  def create
    @audio_reading = current_user.audio_readings.build(audio_reading_params)
  
    if @audio_reading.save
      redirect_to @audio_reading, notice: "アップロードに成功しました！"
    else
      puts "========== VALIDATION ERRORS =========="
      puts @audio_reading.errors.full_messages
      puts "========================================"
      render :new
    end
  end

  def edit; end

  def update
    if @audio_reading.update(audio_reading_params)
      redirect_to @audio_reading, notice: "更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @audio_reading.destroy
    redirect_to audio_readings_path, notice: "削除されました。"
  end

  def search
  end

  def search_result
    @range = params[:range]
    if @range == "audio_reading_id"
      @audio_readings = AudioReading.where(id:params[:id_number]).paginate(page: params[:page])
    else
      @audio_readings = AudioReading.where(user_id:params[:id_number]).paginate(page: params[:page])
    end
  end

  def okiniiris_delete
    @audio_reading = AudioReading.find(params[:id])
    Okiniiri.where(user_id: current_user.id, service_name: "小説朗読" , service_id: @audio_reading.id).destroy_all
    redirect_to audio_reading_path(@audio_reading[:id])
  end

  def okiniiris_add
    @audio_reading = AudioReading.find(params[:id])
    Okiniiri.create({
      user_id: current_user.id,
      service_name: "小説朗読",
      service_id: @audio_reading.id}
    )
    redirect_to audio_reading_path(@audio_reading[:id])
  end

  private

  def set_audio_reading
    @audio_reading = AudioReading.find(params[:id])
  end

  def audio_reading_params
    params.require(:audio_reading).permit(:title, :subtitle, :author_user_id, :audio_file)
  end
end