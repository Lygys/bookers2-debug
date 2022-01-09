class ApplicationMailer < ActionMailer::Base
  default from: '管理人<from@gmail.com>'
  layout 'mailer'
end
