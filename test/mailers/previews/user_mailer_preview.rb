# Preview all emails at https://opulent-tribble-xpr6556vrj4366j4-3000.app.github.dev/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at https://opulent-tribble-xpr6556vrj4366j4-3000.app.github.dev/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  # Preview this email at https://opulent-tribble-xpr6556vrj4366j4-3000.app.github.dev/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end

  # Preview this email at https://opulent-tribble-xpr6556vrj4366j4-3000.app.github.dev/rails/mailers/user_mailer/send_point_send_email
  def send_point_send_email
    user = User.first
    point_mail = PointMail.order(updated_at: :desc).limit(1).first
    point_code = PointCode.order(updated_at: :desc).limit(1).first
    UserMailer.point_send_email(user)
  end

end
