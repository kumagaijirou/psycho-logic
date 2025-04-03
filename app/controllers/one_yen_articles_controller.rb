class OneYenArticlesController < ApplicationController

  def create
    @one_yen_article = OneYenArticle.new(
    user_id: current_user.id,
    title: params[:title],
    article: params[:article],
    article_prompt: params[:article_prompt],
    views: 0,
    prompt_views: 0
    )
    if @one_yen_article.save
      redirect_to one_yen_articles_path
    else
      flash.now[:alert] = "ダイスが足りません。"
      render 'new', status: :unprocessable_entity
    end
  end
  
  def index
    @one_yen_articles = OneYenArticle.all.paginate(page: params[:page])
  end

  def prompt_show
    @usera = current_user
    @one_yen_article = OneYenArticle.find((params[:id]))
    @okiniiri = Okiniiri.where(user_id: current_user.id, service_name: "１円記事", service_id: @one_yen_article.id)
    @point_log = PointLog.find_by(user_id: current_user.id,service_name: "１円記事", service_id: @one_yen_article.id)
    if PointLog.find_by(user_id: current_user.id,service_name: "１円記事",service_id:@one_yen_article.id,dice_point:-500).present?
    elsif @one_yen_article.user_id == current_user.id  
    elsif @usera.dice_point >=  500
      @usera.dice_point = @usera.dice_point - 500
      @usera.save
      @point_log = PointLog.create({
          user_id: @usera.id,
          service_name: "１円記事",
          category: "プロンプトの閲覧料",
          dice_point: -500, 
          service_id: @one_yen_article.id,}
          )
      @userb = User.find(@one_yen_article.user_id)
      @userb.dice_point = @userb.dice_point + 450
      @userb.save
        PointLog.create({
          user_id: @userb.id,
          service_name: "１円記事",
          category: "プロンプトの閲覧された対価",
          dice_point: 450, 
          service_id: @one_yen_article.id,}
          )
      @userc = User.find(1)
      @userc.dice_point = @userc.dice_point + 50
      @userc.save
      PointLog.create({
          user_id: @userc.id,
          service_name: "１円記事",
          category: "プロンプトの閲覧された対価の手数料",
          dice_point: 50, 
          service_id: @one_yen_article.id,}
          )
        @one_yen_article.prompt_views += 1
        @one_yen_article.save
      end    
  end

  def show
    @usera = current_user
    @one_yen_article = OneYenArticle.find((params[:id]))
    @okiniiri = Okiniiri.where(user_id: current_user.id, service_name: "１円記事", service_id: @one_yen_article.id)
    @point_log = PointLog.find_by(user_id: current_user.id,service_name: "１円記事", service_id: @one_yen_article.id)
    if PointLog.find_by(user_id: current_user.id,service_name: "１円記事",service_id:@one_yen_article.id,dice_point:-10).present?
    elsif @one_yen_article.user_id == current_user.id  
    elsif @usera.dice_point >=  10
      @usera.dice_point = @usera.dice_point - 10
      @usera.save
      @point_log = PointLog.create({
          user_id: @usera.id,
          service_name: "１円記事",
          category: "閲覧料",
          dice_point: -10, 
          service_id: @one_yen_article.id,}
          )
      @userb = User.find(@one_yen_article.user_id)
      @userb.dice_point = @userb.dice_point + 9
      @userb.save
        PointLog.create({
          user_id: @userb.id,
          service_name: "１円記事",
          category: "閲覧された対価",
          dice_point: 9, 
          service_id: @one_yen_article.id,}
          )
      @userc = User.find(1)
      @userc.dice_point = @userc.dice_point + 1
      @userc.save
      PointLog.create({
          user_id: @userc.id,
          service_name: "１円記事",
          category: "閲覧された対価の手数料",
          dice_point: 1, 
          service_id: @one_yen_article.id,}
          )
        @one_yen_article.views += 1
        @one_yen_article.save
      end    
  end

  def edit
    @one_yen_article = OneYenArticle.find((params[:id]))
  end

  def search
  end

  def search_result
    @range = params[:range]
    if @range == "one_yen_article_id"
      @one_yen_articles = OneYenArticle.where(id:params[:id_number]).paginate(page: params[:page])
    else
      @one_yen_articles = OneYenArticle.where(user_id:params[:id_number]).paginate(page: params[:page])
    end
  end

  def okiniiris_delete
    @one_yen_article = OneYenArticle.find(params[:id])
    Okiniiri.where(user_id: current_user.id, service_name: "１円記事" , service_id: @one_yen_article.id).destroy_all
    redirect_to one_yen_articles_path(@one_yen_article[:id])
  end

  def okiniiris_add
    @one_yen_article = OneYenArticle.find(params[:id])
    Okiniiri.create({
      user_id: current_user.id,
      service_name: "１円記事",
      service_id: @one_yen_article.id}
    )
    redirect_to one_yen_articles_path(@one_yen_article[:id])
  end

end
