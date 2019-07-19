Rails.application.configure do
  
  config.action_mailer.perform_caching = false

  config.action_mailer.perform_deliveries = true

  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
      user_name:      Rails.application.secrets.mail_username,
      password:       Rails.application.secrets.mail_password,
      domain:         'gmail.com',
      address:       'smtp.gmail.com',
      port:          '587',
      authentication: :plain,
      enable_starttls_auto: true
  }
end