# frozen_string_literal: true

# Rails mailer base class
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
