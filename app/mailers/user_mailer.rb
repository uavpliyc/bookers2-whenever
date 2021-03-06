class UserMailer < ApplicationMailer
  
  def notify_user
      default to: -> { User.pluck(:email) }
      mail(subject: "コーヒーくれ")
  end
  
end
