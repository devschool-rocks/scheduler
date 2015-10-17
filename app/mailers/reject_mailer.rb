class RejectMailer < ApplicationMailer
  default from: 'notifications@onlinedevschool.com'

  def notify_customer(appointment)
    @appointment = appointment
    mail to: appointment.customer.email,
         subject: "Your suggested appointment time with Jim was rejected!"
  end

end

