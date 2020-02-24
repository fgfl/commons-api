# frozen_string_literal: true

if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_commons-api', domain: 'your-frontend-domain'
else
  Rails.application.config.session_store :cookie_store, key: '_commons-api'
end
