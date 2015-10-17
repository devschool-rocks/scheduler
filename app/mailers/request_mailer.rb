class RequestMailer < ApplicationMailer
  default from: 'notifications@onlinedevschool.com'

  def notify_customer(appointment)
    @appointment = appointment
    mail to: appointment.customer.email,
         subject: "You have requested an appointment with Jim OKelly"
  end

  def notify_instructor(appointment)
    @appointment = appointment
    mail to: appointment.instructor.email,
         subjector: "#{appointment.customer.name} has requested an appointment with you!"
  end

end

