class FeedbackAndInquiriesController < ApplicationController

  def create
    @feedback_and_inquiry = FeedbackAndInquiry.new(
    user_id: current_user.id,
    service_name: params[:service_name],
    content: params[:content],
    )
    if @feedback_and_inquiry.save
      redirect_to feedback_and_inquiries_path
    else
      flash.now[:alert] = "ダイスが足りません。"
      render 'new', status: :unprocessable_entity
    end
  end
  
  def index
    @feedback_and_inquiries = FeedbackAndInquiry.all.paginate(page: params[:page])
  end

  def show
    @feedback_and_inquiry = FeedbackAndInquiry.find(params[:feedback_and_inquiries_id])
    
  end
end