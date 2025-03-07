class ResponsesToCommentsAndInquiriesController < ApplicationController

  def create
    @feedback_and_inquiry = FeedbackAndInquiry.find(params[:feedback_and_inquiries_id])
    @responses_to_comments_and_inquiry = ResponsesToCommentsAndInquiry.new(
      feedback_and_inquiries_id: @feedback_and_inquiries_id,
      content: params[:content],
      present_dice_point: params[:present_dice_point]
      )
      if @responses_to_comments_and_inquiry.save
        redirect_to responses_to_comments_and_inquiry_path
      else
        flash.now[:alert] = "ダイスが足りません。"
        render 'new', status: :unprocessable_entity
      end

  end

  def new
   
  end
end