class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウントの有効化"
  end
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードのリセット"
  end

  def point_send_email(user)
    @user = user
    @point_mail = PointMail.order(updated_at: :desc).limit(1).first
    @point_code = PointCode.order(updated_at: :desc).limit(1).first
    mail to: @point_mail.send_user_email, subject: "サイコロジックに招待されました" 
  end
end