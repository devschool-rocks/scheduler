class ApplicationMailer < ActionMailer::Base
  include LocalTimeHelper
  layout 'mailer'
end
