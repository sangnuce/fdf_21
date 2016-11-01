class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailer.active_account")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("mailer.password_reset")
  end
end
